Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbcAVUr4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jan 2016 15:47:56 -0500
Date: Fri, 22 Jan 2016 14:47:44 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Chris J Arges <chris.j.arges@canonical.com>
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
Message-ID: <20160122204744.GI20502@treble.redhat.com>
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <20160122174348.GB29221@canonical.com>
 <20160122191447.GH20502@treble.redhat.com>
 <20160122204034.GA5826@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160122204034.GA5826@canonical.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 22, 2016 at 02:40:35PM -0600, Chris J Arges wrote:
> On Fri, Jan 22, 2016 at 01:14:47PM -0600, Josh Poimboeuf wrote:
> > On Fri, Jan 22, 2016 at 11:43:48AM -0600, Chris J Arges wrote:
> > > On Thu, Jan 21, 2016 at 04:49:04PM -0600, Josh Poimboeuf wrote:
> > > > This is v16 of the compile-time stack metadata validation patch set,
> > > > along with proposed fixes for most of the warnings it found.  It's based
> > > > on the tip/master branch.
> > > >
> > > Josh,
> > > 
> > > Looks good, with my config [1] I do still get a few warnings building
> > > linux/linux-next.
> > > 
> > > Here are the warnings:
> > > $ grep ^stacktool build.log | grep -v staging
> > 
> > Thanks for reporting these!
> > 
> > > stacktool: arch/x86/kvm/vmx.o: vmx_handle_external_intr()+0x67: call without frame pointer save/setup
> > 
> > This can be fixed by setting the stack pointer as an output operand for
> > the inline asm call in vmx_handle_external_intr().
> > 
> > Feel free to submit a patch, or I'll get around to it eventually.
> > 
> > > stacktool: fs/reiserfs/namei.o: set_de_name_and_namelen()+0x9e: return without frame pointer restore
> > > stacktool: fs/reiserfs/namei.o: set_de_name_and_namelen()+0x89: duplicate frame pointer save
> > > stacktool: fs/reiserfs/namei.o: set_de_name_and_namelen()+0x8a: duplicate frame pointer setup
> > > stacktool: fs/reiserfs/namei.o: set_de_name_and_namelen()+0x9e: frame pointer state mismatch
> > > stacktool: fs/reiserfs/namei.o: set_de_name_and_namelen()+0x0: frame pointer state mismatch
> > 
> > These are false positives.  Stacktool is confused by the use of a
> > "noreturn" function which it doesn't know about (__reiserfs_panic).
> > 
> > Unfortunately the only solution I currently have for dealing with global
> > noreturn functions is to just hard-code a list of them.  So the short
> > term fix would be to add "__reiserfs_panic" to the global_noreturns list
> > in tools/stacktool/builtin-check.c.
> > 
> > I'm still trying to figure out a better way to deal with this type of
> > issue, as it's a pain to have to keep a hard-coded list of noreturn
> > functions.  Unfortunately that info isn't available in the ELF.
> > 
> 
> Josh,
> Ok I'll hack on the patches above.
> 
> > > stacktool: fs/reiserfs/ibalance.o: .text: unexpected end of section
> > > stacktool: fs/reiserfs/tail_conversion.o: .text: unexpected end of section
> > 
> > For some reason I'm not able to recreate these warnings...  Can you
> > share one of the .o files?
> 
> Binaries are here:
> http://people.canonical.com/~arges/stacktool/

Thanks, looks like the same __reiserfs_panic() noreturn fix for those.

-- 
Josh
