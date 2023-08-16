<?php

class Party{
    var $name;
    var $seats;
    var $votePercentage;

    function __construct($newName, $newSeats){
        $this->name=$newName;
        $this->seats=$newSeats;
    }

    function __toString(){
        $result="<tr>";
		$result.="<td colspan='3' class='text'>{$this->name}</td>";
		$result.="<td colspan='2' class='text'>{$this->seats}</td>";
		$result.="<td class='text'>{$this->votePercentage}%</td>";
		$result.="</tr>";
		return $result;
    }

    function setVotePercentage($votePercentage){
        $this->votePercentage=$votePercentage;
    }
}