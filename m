Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56144 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbcBXQcy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 11:32:54 -0500
Date: Wed, 24 Feb 2016 10:32:40 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi@firstfloor.org>,
	Pedro Alves <palves@redhat.com>,
	Namhyung Kim <namhyung@gmail.com>,
	Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
	Chris J Arges <chris.j.arges@canonical.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
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
Message-ID: <20160224163240.GB16390@treble.redhat.com>
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <20160223081406.GA606@gmail.com>
 <20160223150155.GB15858@treble.redhat.com>
 <20160224074054.GA13199@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160224074054.GA13199@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 24, 2016 at 08:40:54AM +0100, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > Hi Ingo,
> > 
> > On Tue, Feb 23, 2016 at 09:14:06AM +0100, Ingo Molnar wrote:
> > > So I tried out this latest stacktool series and it looks mostly good for an 
> > > upstream merge.
> > > 
> > > To help this effort move forward I've applied the preparatory/fix patches that are 
> > > part of this series to tip:x86/debug - that's 26 out of 31 patches. (I've 
> > > propagated all the acks that the latest submission got into the changelogs.)
> > 
> > Thanks very much for your review and for applying the fixes!
> > 
> > A few issues relating to the merge:
> > 
> > - The tip:x86/debug branch fails to build because it depends on
> >   ec5186557abb ("x86/asm: Add C versions of frame pointer macros") which
> >   is in tip:x86/asm.
> 
> Indeed...

FYI, v17 will be based on tip:x86/debug.  But note that, when run
against that branch, it'll spit out a lot of these warnings:

  objtool: arch/x86/ia32/sys_ia32.o: __ex_table size not a multiple of 12
  objtool: arch/x86/ia32/ia32_signal.o: __ex_table size not a multiple of 12
  objtool: arch/x86/entry/common.o: __ex_table size not a multiple of 12

Those warnings mean it's expecting the new exception table format which
was added in:

  548acf19234d ("x86/mm: Expand the exception table logic to allow new handling options")

So that commit is needed to avoid the warnings.

Thanks!

-- 
Josh
