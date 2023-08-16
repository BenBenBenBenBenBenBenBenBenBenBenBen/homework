<?php

include "candidate.php";

class Electorate{
    var $name;
    var $winningParty;
    var $allMyCandidates=array();

    function __construct($newName){
        $this->name=$newName;
    }

    function __toString(){
        $result="<tr>";
		$result.="<td colspan='3' class='text'>{$this->name}</td>";
		$result.="<td colspan='3' class='text'>{$this->winningParty}</td>";
		$result.="</tr>";
		return $result;
    }

    function addCandidate($name, $party){
        $aCandidate=new Candidate($name, $party);
        array_push($this->allMyCandidates, $aCandidate);
    }

    function setCandidateVote($name, $candidateVote){
        for ($i=0; $i<count($this->allMyCandidates); $i++){
            if ($this->allMyCandidates[$i]->name===$name){
                $this->allMyCandidates[$i]->setCandidateVote($candidateVote);
                break;
            }
        }
    }

    function findCandidate($targetCandidateName){
        $foundCandidate=null;
        for ($i=0; $i<count($this->allMyCandidates); $i++){
            if ($this->allMyCandidates[$i]->name===$targetCandidateName){
                $foundCandidate=$this->allMyCandidates[$i];
                break;
            }
        }
        return $foundCandidate;
    }

    function getCandidates(){
        $this->sortCandidates();
        $out="<tr><th colspan='3' class='subHeading'>{$this->name}</th><th colspan='3' class='subHeading'>(Sorted by vote)</th></tr>";
        for ($i=0; $i<count($this->allMyCandidates); $i++){
            $out.=$this->allMyCandidates[$i]->__toString();
        }
        return $out;
    }

    function setWinningParty($winningParty){
        $this->winningParty=$winningParty;
    }

    function sortCandidates(){
        usort($this->allMyCandidates, function ($a, $b) {
            if ($b->name > $a->name){
                return 1;
            }
            if ($b->name < $a->name){
                return -1;
            }
            return 0;
        });
    }
}