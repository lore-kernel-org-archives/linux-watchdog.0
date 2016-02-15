Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:32882 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcBOUCF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Feb 2016 15:02:05 -0500
Date: Mon, 15 Feb 2016 21:02:01 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alok Kataria <akataria@vmware.com>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
	linux-watchdog@vger.kernel.org, Pedro Alves <palves@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Michal Marek <mmarek@suse.cz>,
	Namhyung Kim <namhyung@gmail.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Waiman Long <Waiman.Long@hpe.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jiri Slaby <jslaby@suse.cz>, kvm@vger.kernel.org,
	x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Borislav Petkov <bp@alien8.de>,
	Chris Wright <chrisw@sous-sol.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	David Vrabel <david.vrabel@citrix.com>,
	live-patching@vger.kernel.org, netdev@vger.kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Gleb Natapov <gleb@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Chris J Arges <chris.j.arges@canonical.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Len Brown <len.brown@intel.com>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/33] Compile-time stack metadata validation
Message-ID: <20160215200201.GN3696@two.firstfloor.org>
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <56BDB5A8.9030006@suse.cz>
 <20160212144543.GA29004@treble.redhat.com>
 <20160212171037.GV6357@twins.programming.kicks-ass.net>
 <20160212183206.GB29004@treble.redhat.com>
 <20160212201011.GW6357@twins.programming.kicks-ass.net>
 <20160215163134.GA20585@treble.redhat.com>
 <CA+55aFzoPCd_LcSx1FUuEhSBYk2KrfzXGj-Vcn39W5bz=KuZhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzoPCd_LcSx1FUuEhSBYk2KrfzXGj-Vcn39W5bz=KuZhA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > There are two ways to fix the warnings:
> >
> > 1. get rid of the thunks and call the C functions directly; or
> 
> No. Not until gcc learns about per-function callibg conventions (so that it can
> be marked as not clobbering registers).

It does already for static functions in 5.x (with -fipa-ra).
And with LTO it can be used even somewhat globally.

Even older version supported it, for only for x86->SSE on 32bit, which
is useless for the kernel. But the new IPA-RA propagates which registers
are clobbered.

That said it will probably be a long time until we can drop support for
older compilers.  So for now the manual method is still needed.

-Andi

