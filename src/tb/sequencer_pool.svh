/***********************************************************************
 * Author : Amr El Batarny
 * File   : sequencer_pool.sv
 * Brief  : Singleton sequencer pool for storing and retrieving sequencer
 *          handles by name, eliminating the need for virtual sequencers.
 * Note   : Documentation comments generated with AI assistance using
 *          the same format found in UVM source code.
 **********************************************************************/

//------------------------------------------------------------------------------
//
// CLASS: sequencer_pool
//
// The sequencer_pool class provides a singleton container for storing and
// retrieving sequencer handles using string-based keys. It extends uvm_pool
// to create a globally accessible associative array that maps unique sequencer
// names to their handles. This eliminates the need for virtual sequencers and
// enables hierarchical independence in UVM testbenches.
//
// Type Parameters:
//   T - Sequencer type (defaults to uvm_sequencer_base)
//
//------------------------------------------------------------------------------

class sequencer_pool #(type T=uvm_sequencer_base) extends uvm_pool #(string,T); 
 
    typedef sequencer_pool #(T) this_type; 

    static protected this_type m_global_pool; 


    // Function: new
    //
    // Protected constructor that prevents direct instantiation, ensuring singleton
    // pattern by allowing only get_global_pool() to create the instance.

    extern protected function new (string name="");


    // Function: get_global_pool
    //
    // Static method that returns the singleton instance of the sequencer pool.
    // Creates the pool on first call, returns existing instance on subsequent calls.

    extern static function this_type get_global_pool ();


    // Function: get_global
    //
    // Static method that retrieves a sequencer handle from the global pool by key.
    // Convenience wrapper for get_global_pool().get(key).

    extern static function T get_global (KEY key);


    // Function: get
    //
    // Retrieves a sequencer handle by name from the pool. Issues fatal error and
    // dumps pool contents if the requested key does not exist, preventing null
    // handle references that would cause runtime failures.

    extern virtual function T get (string key);


    // Function: add
    //
    // Adds a sequencer handle to the pool with a unique string key. Issues fatal
    // error if the key already exists, preventing silent overwrites that would
    // lose existing sequencer handles and cause hard-to-debug failures.

    extern virtual function void add(string key, uvm_sequencer_base item);


    // Function: dump
    //
    // Prints all sequencer handles stored in the pool in a simplified format,
    // showing the user-defined key name and the full hierarchical path to each
    // sequencer. Useful for debugging sequencer availability and naming.

    extern virtual function void dump();

endclass : sequencer_pool


//------------------------------------------------------------------------------
// IMPLEMENTATION
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
// CLASS- sequencer_pool
//
//------------------------------------------------------------------------------


// new
// ---

function sequencer_pool::new(string name="");
  super.new(name); 
endfunction : new

// get_global_pool
// ---------------

function sequencer_pool::this_type sequencer_pool::get_global_pool();
    if (m_global_pool==null) 
        m_global_pool = new("pool"); 
    return m_global_pool; 
endfunction : get_global_pool

// get_global
// ----------

function sequencer_pool::T sequencer_pool::get_global(KEY key);
    this_type gpool; 
    gpool = get_global_pool();  
    return gpool.get(key); 
endfunction : get_global

// get
// ---

function sequencer_pool::T sequencer_pool::get(string key);
    if (pool.exists(key)) return pool[key];
    else begin
        dump(); 
        `uvm_fatal("SQR_POOL", 
        $sformatf("No pool entry exists for sqr name %s", key)) 
    end 
endfunction : get

// add
// ---

function void sequencer_pool::add(string key, uvm_sequencer_base item);
    if(key != "") begin 
        if(pool.exists(key)) 
            `uvm_fatal("SQR_POOL", 
            $sformatf("Duplicate name_table entry: name %s", key)) 
        pool[key] = item; 
    end 
endfunction : add

// dump
// ----

function void sequencer_pool::dump();
    $display("\n--- SEQUENCER POOL ENTRIES -------"); 
    foreach(pool[name]) begin 
        uvm_sequencer_base sqr = pool[name];
        $write  ("%10s : ", name);
        $display("%s", sqr.get_full_name());
    end 
    $display("--- END SEQUENCER POOL     -------\n"); 
endfunction : dump
