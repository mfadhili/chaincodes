/*
SPDX-License-Identifier: Apache-2.0
*/

package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/golang/protobuf/ptypes"
	"github.com/hyperledger/fabric-chaincode-go/shim"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type serverConfig struct {
	CCID    string
	Address string
}

// SmartContract provides functions for managing an produce
type SmartContract struct {
	contractapi.Contract
}

// Produce basic details of what makes up a simple produce
type Produce struct {
	ProdID               string  `json:"ID"`
	FarmName             string  `json:"FarmName"`
	FarmAddress          string  `json:"farmAddress"`
	FarmLocation         string  `json:"farmLocation"`
	ProduceName          string  `json:"produceName"`
	ProduceType          string  `json:"produceType"`
	ProduceLotNo         string  `json:"produceLotNo"`
	ProduceUnits         string  `json:"produceUnits"`
	ProduceQuantity      float64 `json:"produceQuantity"`
	HarvestDate          string  `json:"harvestDate"`
	IntermediaryName     string  `json:"intermediaryName"`
	IntermediaryAddress  string  `json:"intermediaryAddress"`
	IntermediaryLocation string  `json:"intermediaryLocation"`
	Processes            string  `json:"Processes"`
	ProcessLotNo         string  `json:"processLotNo"`
	ProcessDate          string  `json:"processDate"`
	OtherInfo            string  `json:"otherInfo"`
	IntermediaryType     string  `json:"intermediaryType"`
	FarmContact          string  `json:"farmContact"`
}

// HistoryQueryResult structure used for returning result of history query
type HistoryQueryResult struct {
	Record    *Produce  `json:"record"`
	TxId      string    `json:"txId"`
	Timestamp time.Time `json:"timestamp"`
	IsDelete  bool      `json:"isDelete"`
}

// QueryResult structure used for handling result of query
type QueryResult struct {
	Key    string `json:"Key"`
	Record *Produce
}

// InitLedger adds a base set of cars to the ledger
func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
	produces := []Produce{
		{ProdID: "P00001", FarmName: "MkulimaFarms", FarmAddress: "8065 Rocky River Lane Adrian, MI 49221", FarmContact: "(854) 431-8431", FarmLocation: "22°40′S 50°25′W", ProduceName: "Fresh Eggs", ProduceType: "Eggs", ProduceLotNo: "PL5356453", ProduceUnits: "dozen", ProduceQuantity: 35, HarvestDate: "2023-01-15", IntermediaryName: "", IntermediaryAddress: "", IntermediaryType: "", IntermediaryLocation: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00002", FarmName: "Elysian Acres", FarmAddress: "3 Indian Summer Drive Daphne, AL 36526", FarmContact: "(981) 797-8861", FarmLocation: "27°57′N 82°28′W", ProduceName: "Farmer Teresia’s Organic Pineapple", ProduceType: "Pineapple", ProduceLotNo: "PL5356454", ProduceUnits: "kilograms", ProduceQuantity: 40, HarvestDate: "2023-11-05", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00003", FarmName: "Hazelwood Farm", FarmAddress: "8655 Dogwood St.Littleton, CO 80123", FarmContact: "(413) 579-4134", FarmLocation: "20°01′N 75°49′W", ProduceName: "ForestFoods Certified Organic Bird’s Eye Green Chilies", ProduceType: "Chillies", ProduceLotNo: "PL5356455", ProduceUnits: "grams", ProduceQuantity: 3000, HarvestDate: "2023-03-13", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00004", FarmName: "Black Sheep Ranch", FarmAddress: "7536 Grove Dr.Branford, CT 06405", FarmContact: "(865) 326-8417", FarmLocation: "31°06′N 77°10′E", ProduceName: "WHB Dry Aged Rack of Lamb (Frozen)", ProduceType: "Lamb", ProduceLotNo: "PL5356456", ProduceUnits: "kilograms", ProduceQuantity: 34, HarvestDate: "2023-06-28", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00005", FarmName: "Joyful Goat Farm", FarmAddress: "277 Princeton St.Colorado Springs, CO 80911", FarmContact: "(614) 708-9759", FarmLocation: "57°37′N 39°51′E", ProduceName: "Bio Whole Milk", ProduceType: "Milk", ProduceLotNo: "PL5356457", ProduceUnits: "Liters", ProduceQuantity: 200, HarvestDate: "2023-03-27", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00006", FarmName: "Funky Chicken Farm", FarmAddress: "8065 Rocky River Lane Adrian, MI 49221", FarmContact: "(256) 596-3619", FarmLocation: "71°39′N 128°52′E", ProduceName: "Farmhouse Boneless Chicken Breast", ProduceType: "Chicken", ProduceLotNo: "PL5356458", ProduceUnits: "Kilograms", ProduceQuantity: 50, HarvestDate: "2023-03-13", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00007", FarmName: "Animal Farm", FarmAddress: "155 Gregory Road Mount Pleasant, SC 29464", FarmContact: "(209) 660-7033", FarmLocation: "2°32′S 140°43′E", ProduceName: "Nautic Delights Fish Cakes", ProduceType: "Fish", ProduceLotNo: "PL5356459", ProduceUnits: "grams", ProduceQuantity: 830, HarvestDate: "2023-02-07", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
		{ProdID: "P00008", FarmName: "Goldenrod Gardens", FarmAddress: "8065 Rocky River Lane Adrian, MI 49221", FarmContact: "(598) 614-3773", FarmLocation: "21°08′N 79°05′E", ProduceName: "Sylvia Basket Organic Yellow Fleshed Sweet Potato", ProduceType: "Sweet Potato", ProduceLotNo: "PL5356460", ProduceUnits: "kilograms", ProduceQuantity: 96, HarvestDate: "2023-10-12", IntermediaryName: "", IntermediaryAddress: "", IntermediaryLocation: "", IntermediaryType: "", Processes: "", ProcessLotNo: "", ProcessDate: "", OtherInfo: ""},
	}

	for _, produce := range produces {
		ProduceJSON, err := json.Marshal(produce)
		if err != nil {
			return err
		}

		err = ctx.GetStub().PutState(produce.ProdID, ProduceJSON)
		if err != nil {
			return fmt.Errorf("failed to put to world state: %v", err)
		}
	}

	return nil
}

// CreateProduce issues a new produce to the world state with given details.
func (s *SmartContract) CreateProduce(ctx contractapi.TransactionContextInterface, prodId, farmName, farmAddress, farmContact, farmLocation, produceName, produceType string, produceLotNo string, produceUnits string, produceQuantity float64, harvestDate string, intermediaryName, intermediaryType, intermediaryAddress, IntermediaryLocation, processes, processLotNo, processDate, otherInfo string) error {
	exists, err := s.ProduceExists(ctx, prodId)
	if err != nil {
		return err
	}
	if exists {
		return fmt.Errorf("the produce %s already exists", prodId)
	}
	produce := Produce{
		ProdID:               prodId,
		FarmName:             farmName,
		FarmAddress:          farmAddress,
		FarmContact:          farmContact,
		FarmLocation:         farmLocation,
		ProduceName:          produceName,
		ProduceType:          produceType,
		ProcessLotNo:         produceLotNo,
		ProduceUnits:         produceUnits,
		ProduceQuantity:      produceQuantity,
		HarvestDate:          harvestDate,
		IntermediaryName:     intermediaryName,
		IntermediaryType:     intermediaryType,
		IntermediaryLocation: IntermediaryLocation,
		IntermediaryAddress:  intermediaryAddress,
		Processes:            processes,
		ProcessDate:          processDate,
		ProduceLotNo:         processLotNo,
		OtherInfo:            otherInfo,
	}

	ProduceJSON, err := json.Marshal(produce)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(prodId, ProduceJSON)
}

// ReadProduce returns the produce stored in the world state with given id.
func (s *SmartContract) ReadProduce(ctx contractapi.TransactionContextInterface, prodId string) (*Produce, error) {
	ProduceJSON, err := ctx.GetStub().GetState(prodId)
	if err != nil {
		return nil, fmt.Errorf("failed to read from world state. %s", err.Error())
	}
	if ProduceJSON == nil {
		return nil, fmt.Errorf("the produce %s does not exist", prodId)
	}

	var produce Produce
	err = json.Unmarshal(ProduceJSON, &produce)
	if err != nil {
		return nil, err
	}

	return &produce, nil
}

// UpdateProduce updates an existing asset in the world state with provided parameters.
func (s *SmartContract) UpdateProduce(ctx contractapi.TransactionContextInterface, prodId, farmName, farmAddress, farmContact, farmLocation, produceName, produceType string, produceLotNo string, produceUnits string, produceQuantity float64, harvestDate string, intermediaryName, intermediaryType, intermediaryAddress, IntermediaryLocation, processes, processLotNo, processDate, otherInfo string) error {
	exists, err := s.ProduceExists(ctx, prodId)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("the produce %s does not exist", prodId)
	}

	// overwriting original produce with new produce
	produce := Produce{
		ProdID:               prodId,
		FarmName:             farmName,
		FarmAddress:          farmAddress,
		FarmContact:          farmContact,
		FarmLocation:         farmLocation,
		ProduceName:          produceName,
		ProduceType:          produceType,
		ProcessLotNo:         produceLotNo,
		ProduceUnits:         produceUnits,
		ProduceQuantity:      produceQuantity,
		HarvestDate:          harvestDate,
		IntermediaryName:     intermediaryName,
		IntermediaryType:     intermediaryType,
		IntermediaryLocation: IntermediaryLocation,
		IntermediaryAddress:  intermediaryAddress,
		Processes:            processes,
		ProcessDate:          processDate,
		ProduceLotNo:         processLotNo,
		OtherInfo:            otherInfo,
	}

	ProduceJSON, err := json.Marshal(produce)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(prodId, ProduceJSON)
}

// DeleteProduce deletes any given produce from the world state.
func (s *SmartContract) DeleteProduce(ctx contractapi.TransactionContextInterface, prodId string) error {
	exists, err := s.ProduceExists(ctx, prodId)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("the produce %s does not exist", prodId)
	}

	return ctx.GetStub().DelState(prodId)
}

// ProduceExists returns true when asset with given ID exists in world state
func (s *SmartContract) ProduceExists(ctx contractapi.TransactionContextInterface, id string) (bool, error) {
	ProduceJSON, err := ctx.GetStub().GetState(id)
	if err != nil {
		return false, fmt.Errorf("failed to read from world state. %s", err.Error())
	}

	return ProduceJSON != nil, nil
}

// TransferProduce updates the owner field of produce with given prodId in world state.
func (s *SmartContract) TransferProduce(ctx contractapi.TransactionContextInterface, id string, intermediaryName, intermediaryType, intermediaryAddress, IntermediaryLocation, processes, processLotNo, processDate, otherInfo string) error {
	produce, err := s.ReadProduce(ctx, id)
	if err != nil {
		return err
	}

	produce.IntermediaryName = intermediaryName
	produce.IntermediaryType = intermediaryType
	produce.IntermediaryAddress = intermediaryAddress
	produce.IntermediaryLocation = IntermediaryLocation
	produce.Processes = processes
	produce.ProcessLotNo = processLotNo
	produce.ProcessDate = processDate
	produce.OtherInfo = otherInfo

	ProduceJSON, err := json.Marshal(produce)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(id, ProduceJSON)
}

// GetAllProduce returns all produce found in world state
func (s *SmartContract) GetAllProduce(ctx contractapi.TransactionContextInterface) ([]QueryResult, error) {
	// range query with empty string for startKey and endKey does an open-ended query of all assets in the chaincode namespace.
	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")

	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	var results []QueryResult

	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()

		if err != nil {
			return nil, err
		}

		var produce Produce
		err = json.Unmarshal(queryResponse.Value, &produce)
		if err != nil {
			return nil, err
		}

		queryResult := QueryResult{Key: queryResponse.Key, Record: &produce}
		results = append(results, queryResult)
	}

	return results, nil
}

// GetProduceHistory returns the chain of custody for any produce since creation.
func (t *SmartContract) GetProduceHistory(ctx contractapi.TransactionContextInterface, prodID string) ([]HistoryQueryResult, error) {
	log.Printf("GetProduceHistory: ID %v", prodID)

	resultsIterator, err := ctx.GetStub().GetHistoryForKey(prodID)
	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	var records []HistoryQueryResult
	for resultsIterator.HasNext() {
		response, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}

		var produce Produce
		if len(response.Value) > 0 {
			err = json.Unmarshal(response.Value, &produce)
			if err != nil {
				return nil, err
			}
		} else {
			produce = Produce{
				ProdID: prodID,
			}
		}

		timestamp, err := ptypes.Timestamp(response.Timestamp)
		if err != nil {
			return nil, err
		}

		record := HistoryQueryResult{
			TxId:      response.TxId,
			Timestamp: timestamp,
			Record:    &produce,
			IsDelete:  response.IsDelete,
		}
		records = append(records, record)
	}

	return records, nil
}

func main() {
	// See chaincode.env.example
	config := serverConfig{
		CCID:    os.Getenv("CHAINCODE_ID"),
		Address: os.Getenv("CHAINCODE_SERVER_ADDRESS"),
	}

	chaincode, err := contractapi.NewChaincode(&SmartContract{})

	if err != nil {
		log.Panicf("error create produce-trace chaincode: %s", err)
	}

	server := &shim.ChaincodeServer{
		CCID:    config.CCID,
		Address: config.Address,
		CC:      chaincode,
		TLSProps: shim.TLSProperties{
			Disabled: true,
		},
	}

	if err := server.Start(); err != nil {
		log.Panicf("error starting produce-trace chaincode: %s", err)
	}
}
