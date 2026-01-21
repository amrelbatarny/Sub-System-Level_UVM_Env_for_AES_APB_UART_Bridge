/***********************************************************************
 * Author : Amr El Batarny
 * File   : AES_sequencer.svh
 * Brief  : Parameterized AES sequencer for routing sequence items to
 *          AES drivers.
 * Note   : Documentation comments generated with AI assistance using
 *          the same format found in UVM source code.
 **********************************************************************/

//------------------------------------------------------------------------------
//
// CLASS: AES_sequencer
//
// The AES_sequencer class provides a parameterized sequencer implementation
// for AES transactions, enabling flexible sequencer instantiation with
// different transaction item types.
//
//------------------------------------------------------------------------------

class AES_sequencer extends uvm_sequencer #(AES_sequence_item);
  `uvm_component_utils(AES_sequencer)


  // Function: new
  //
  // Creates a new AES_sequencer instance with the given name and parent.

  extern function new(string name="AES_sequencer", uvm_component parent=null);

endclass : AES_sequencer


//------------------------------------------------------------------------------
// IMPLEMENTATION
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
// CLASS- AES_sequencer
//
//------------------------------------------------------------------------------


// new
// ---

function AES_sequencer::new(string name="AES_sequencer", uvm_component parent=null);
  super.new(name, parent);
endfunction