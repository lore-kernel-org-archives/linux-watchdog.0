Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbcBLScU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Feb 2016 13:32:20 -0500
Date: Fri, 12 Feb 2016 12:32:06 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi@firstfloor.org>,
	Pedro Alves <palves@redhat.com>,
	Namhyung Kim <namhyung@gmail.com>,
	Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
	Chris J Arges <chris.j.arges@canonical.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	David Vrabel <david.vrabel@citrix.com>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Chris Wright <chrisw@sous-sol.org>,
	Alok Kataria <akataria@vmware.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Gleb Natapov <gleb@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, Waiman Long <Waiman.Long@hpe.com>
Subject: Re: [PATCH 00/33] Compile-time stack metadata validation
Message-ID: <20160212183206.GB29004@treble.redhat.com>
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <56BDB5A8.9030006@suse.cz>
 <20160212144543.GA29004@treble.redhat.com>
 <20160212171037.GV6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160212171037.GV6357@twins.programming.kicks-ass.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 12, 2016 at 06:10:37PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 12, 2016 at 08:45:43AM -0600, Josh Poimboeuf wrote:
> > On Fri, Feb 12, 2016 at 11:36:24AM +0100, Jiri Slaby wrote:
> > 
> > This seems like a real frame pointer bug caused by the following line in
> > arch/x86/include/asm/preempt.h:
> > 
> >   # define __preempt_schedule() asm ("call ___preempt_schedule")
> 
> The purpose there is that:
> 
> 	preempt_enable();
> 
> turns into:
> 
> 	decl	__percpu_prefix:__preempt_count
> 	jnz	1f:
> 	call	___preempt_schedule
> 1:
> 
> See arch/x86/include/asm/preempt.h:__preempt_count_dec_and_test()

Sorry, I'm kind of confused.  Do you mean that's what preempt_enable()
would turn into *without* the above define?

What I actually see in the listing is:

 	decl	__percpu_prefix:__preempt_count
 	je	1f:
	....
 1:
 	call	___preempt_schedule

So it puts the "call ___preempt_schedule" in the slow path.

I also don't see how that would be related to the use of the asm
statement in the __preempt_schedule() macro.  Doesn't the use of
unlikely() in preempt_enable() put the call in the slow path?

  #define preempt_enable() \
  do { \
	  barrier(); \
	  if (unlikely(preempt_count_dec_and_test())) \
		  preempt_schedule(); \
  } while (0)

Also, why is the thunk needed?  Any reason why preempt_enable() can't be
called directly from C?

-- 
Josh
