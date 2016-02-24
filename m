Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35839 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbcBXHlA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 02:41:00 -0500
Date: Wed, 24 Feb 2016 08:40:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
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
Message-ID: <20160224074054.GA13199@gmail.com>
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <20160223081406.GA606@gmail.com>
 <20160223150155.GB15858@treble.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160223150155.GB15858@treble.redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Hi Ingo,
> 
> On Tue, Feb 23, 2016 at 09:14:06AM +0100, Ingo Molnar wrote:
> > So I tried out this latest stacktool series and it looks mostly good for an 
> > upstream merge.
> > 
> > To help this effort move forward I've applied the preparatory/fix patches that are 
> > part of this series to tip:x86/debug - that's 26 out of 31 patches. (I've 
> > propagated all the acks that the latest submission got into the changelogs.)
> 
> Thanks very much for your review and for applying the fixes!
> 
> A few issues relating to the merge:
> 
> - The tip:x86/debug branch fails to build because it depends on
>   ec5186557abb ("x86/asm: Add C versions of frame pointer macros") which
>   is in tip:x86/asm.

Indeed...

> - As Pavel mentioned, the tip-bot seems to be spitting out garbage
>   emails from:
>   =?UTF-8?B?dGlwLWJvdCBmb3IgSm9zaCBQb2ltYm9ldWYgPHRpcGJvdEB6eXRvci5jb20+?=@zytor.com.

Yeah, hpa fixed that meanwhile.

Due to the above bad base I rebased the tree (to a x86/asm base), so there will be 
a new round of (hopefully readable) tip-bot notifications. I'll push it out after 
a bit of testing.

> > 5)
> > 
> > Likewise, I think the CONFIG_STACK_VALIDATION=y Kconfig flag does not express that 
> > we do exception table checks as well - and it does not express all the other 
> > things we may check in object files in the future.
> > 
> > Something like CONFIG_CHECK_OBJECT_FILES=y would express it, and the help text 
> > would list all the things the tool is able to checks for at the moment.
> 
> Hm, I'm not really sure about this.  Yes, the tool could potentially do
> other types of checks, but is it necessary to lump them all together
> into a single config option?  It does have subcommands after all ;-)

lol ;-)

Ok, I'm fine with CONFIG_STACK_VALIDATION=y as well.

Thanks,

	Ingo
