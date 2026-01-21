/***********************************************************************
 * Author : Amr El Batarny
 * File   : virtual_sequence_base.svh
 * Brief  : Base class for virtual sequences providing infrastructure
 *          for managing multiple child sequencers.
 * Note   : Documentation comments generated with AI assistance using
 *          the same format found in UVM source code.
 **********************************************************************/

//------------------------------------------------------------------------------
//
// CLASS: virtual_sequence_base
//
// The virtual_sequence_base class provides a virtual base for virtual sequences
// that coordinate multiple child sequences across different sequencers. It
// maintains handles to child sequencers and their associated sequences.
//
//------------------------------------------------------------------------------

typedef class APB_reactive_sequence_1;
typedef class APB_reactive_sequence_2;

class virtual_sequence_base extends uvm_sequence;
    `uvm_object_utils(virtual_sequence_base)

    typedef sequencer_pool #(uvm_sequencer_base) sqr_pool_type;

    uvm_sequencer_base apb_seqr_1;
    uvm_sequencer_base apb_seqr_2;

    sqr_pool_type sqrs = sqr_pool_type::get_global_pool();

    APB_reactive_sequence_1 apb_seq_1;
    APB_reactive_sequence_2 apb_seq_2;


    // Function: new
    //
    // Creates a new virtual_sequence_base instance with the given name.

    extern function new(string name = "virtual_sequence_base");

    extern function void set_sqr_handles();

endclass : virtual_sequence_base


//------------------------------------------------------------------------------
// IMPLEMENTATION
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
// CLASS- virtual_sequence_base
//
//------------------------------------------------------------------------------


// new
// ---

function virtual_sequence_base::new(string name = "virtual_sequence_base");
    super.new(name);
endfunction : new

// set_sqr_handles
// ----

function void virtual_sequence_base::set_sqr_handles();
    apb_seqr_1 = sqrs.get("apb_seqr_1");
    apb_seqr_2 = sqrs.get("apb_seqr_2");
endfunction
