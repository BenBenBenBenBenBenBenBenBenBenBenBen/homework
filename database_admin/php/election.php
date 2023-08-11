<?php

include "party.php";
include "electorate.php";

class Election{
    var $name;
    var $year;
    var $allMyParties=array();
    var $allMyElectorates=array();

    function __construct($newName, $newYear){
        $this->name=$newName;
        $this->year=$newYear;
    }

    function __toString(){
        $this->sortParties();
        $out="<table><tr><th colspan='6' class='heading'>{$this->name} {$this->year}</th></tr><tr><th colspan='3' class='subHeading'>Parties</th><th colspan='2' class='subHeading'>Seats</th><th class='subHeading'>Vote%</th></tr>";
        for ($i=0; $i<count($this->allMyParties); $i++){
            $out.=$this->allMyParties[$i]->__toString();
        }
        $out.="<tr><th colspan='3' class='subHeading'>Electorates</th><th colspan='3' class='subHeading'>Winning Party</th></tr>";
        $this->sortElectorates();
        for ($i=0; $i<count($this->allMyElectorates); $i++){
            $out.=$this->allMyElectorates[$i]->__toString();
        }
        for ($i=0; $i<count($this->allMyElectorates); $i++){
            if (count($this->allMyElectorates[$i]->allMyCandidates)!=0){
                $out.=$this->allMyElectorates[$i]->getCandidates();
            }
        }
        $out.="</table>";
        return $out;
    }

    function addParty($name, $seats){
        $aParty=new Party($name, $seats);
        array_push($this->allMyParties, $aParty);
    }

    function setVotePercentage($name, $votePercentage){
        for ($i=0; $i<count($this->allMyParties); $i++){
            if ($this->allMyParties[$i]->name===$name){
                $this->allMyParties[$i]->setVotePercentage($votePercentage);
                break;
            }
        }
    }

    function addElectorate($name){
        $aElectorate=new Electorate($name);
        array_push($this->allMyElectorates, $aElectorate);
    }

    function setWinningParty($name, $winningParty){
        for ($i=0; $i<count($this->allMyElectorates); $i++){
            if ($this->allMyElectorates[$i]->name===$name){
                $this->allMyElectorates[$i]->setWinningParty($winningParty);
                break;
            }
        }
    }

    function findElectorate($targetElectorateName){
        $foundElectorate=null;
        for ($i=0; $i<count($this->allMyElectorates); $i++){
            if ($this->allMyElectorates[$i]->name===$targetElectorateName){
                $foundElectorate=$this->allMyElectorates[$i];
                break;
            }
        }
        return $foundElectorate;
    }

    function sortParties(){
        usort($this->allMyParties, function ($a, $b) {
            if ($b->votePercentage > $a->votePercentage){
                return 1;
            }
            if ($b->votePercentage < $a->votePercentage){
                return -1;
            }
            return 0;
        });
    }
    function sortElectorates(){
        usort($this->allMyElectorates, function ($a, $b) {
            if ($b->name < $a->name){
                return 1;
            }
            if ($b->name > $a->name){
                return -1;
            }
            return 0;
        });
    }
}