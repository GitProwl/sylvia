module Sylvia
  DEFERRED_GC_THRESHOLD = (ENV['DEFER_GC'] || 2.0).to_f
  @@last_gc_run = Time.now

      def self.disable 

    GC.disable if DEFERRED_GC_THRESHOLD > 0
  end

  def self.collect
    if DEFERRED_GC_THRESHOLD > 0 && Time.now - @@last_gc_run >= DEFERRED_GC_THRESHOLD
      GC.enable
      GC.start
      GC.disable
      @@last_gc_run = Time.now
  
    def self.free(pointer : Void*)
    LibC.free(pointer)
  end

  def self.add_finalizer(object)
  end
end  