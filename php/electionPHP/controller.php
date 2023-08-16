<?php

include "election.php";

class Controller{
    public static function setup($ElectionJSON){
        $theElection=new Election($ElectionJSON["Election"]["name"], $ElectionJSON["Election"]["year"]);
        $theElectorate='';
        for ($i=0; $i<count($ElectionJSON["Parties"]); $i++){
            $theElection->addparty($ElectionJSON["Parties"][$i]["name"], $ElectionJSON["Parties"][$i]["seats"]);
            $theElection->setVotePercentage($ElectionJSON["Parties"][$i]["name"], floatval($ElectionJSON["Parties"][$i]["votePercentage"]));
        }
        for ($i=0; $i<count($ElectionJSON["Electorates"]); $i++){
            $theElection->addElectorate($ElectionJSON["Electorates"][$i]["name"]);
            $theElection->setWinningParty($ElectionJSON["Electorates"][$i]["name"], $ElectionJSON["Electorates"][$i]["winningParty"]);
            if ($ElectionJSON["Electorates"][$i]["allMyCandidates"]!=0){
                $theElectorate=$theElection->findElectorate($ElectionJSON["Electorates"][$i]["name"]);
                for ($j=0; $j<count($ElectionJSON["Electorates"][$i]["allMyCandidates"]); $j++){
                    $theElectorate->addCandidate($ElectionJSON["Electorates"][$i]["allMyCandidates"][$j]["candidateName"], $ElectionJSON["Electorates"][$i]["allMyCandidates"][$j]["candidateParty"]);
                    $theElectorate->setCandidateVote($ElectionJSON["Electorates"][$i]["allMyCandidates"][$j]["candidateName"], $ElectionJSON["Electorates"][$i]["allMyCandidates"][$j]["candidateVote"]);
                }
            }
        }
        return $theElection;
    }
}