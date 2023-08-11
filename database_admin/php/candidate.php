<?php

class Candidate{
    var $name;
    var $party;
    var $candidateVote;
    
    function __construct($newName, $newParty){
        $this->name=$newName;
        $this->party=$newParty;
    }

    function __toString(){
        $result="<tr>";
		$result.="<td colspan='3' class='text'>{$this->name}</td>";
		$result.="<td colspan='2' class='text'>{$this->party}</td>";
		$result.="<td class='text'>{$this->candidateVote}</td>";
		$result.="</tr>";
		return $result;
    }

    function setCandidateVote($candidateVote){
        $this->candidateVote=$candidateVote;
    }
}