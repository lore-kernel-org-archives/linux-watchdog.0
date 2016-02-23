Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43421 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbcBWO1W (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Feb 2016 09:27:22 -0500
Date: Tue, 23 Feb 2016 11:27:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20160223142717.GA3607@kernel.org>
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <20160223081406.GA606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160223081406.GA606@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Em Tue, Feb 23, 2016 at 09:14:06AM +0100, Ingo Molnar escreveu:
> The fact that 'stacktool' already checks about assembly details like __ex_table[] 
> shows that my review feedback early iterations of this series, that the 
> 'stacktool' name is too specific, was correct.
> 
> We really need to rename it before it gets upstream and the situation gets worse. 
> __ex_table[] has obviously nothing to do with the 'stack layout' of binaries.
> 
> Another suitable name would be 'asmtool' or 'objtool'. For example the following 
> would naturally express what it does:
> 
>   objtool check kernel/built-in.o
> 
> the name expresses that the tool checks object files, independently of the 
> existing toolchain. Its primary purpose right now is the checking of stack layout 
> details, but the tool is not limited to that at all.

Removing 'tool' from the tool name would be nice too :-) Making it
easily googlable would be good too, lotsa people complain about 'perf'
being too vague, see for a quick laugher:

http://www.brendangregg.com/perf.html

``Searching for just "perf" finds sites on the police, petroleum, weed
control, and a T-shirt. This is not an official perf page, for either
perf_events or the T-shirt.''

The T-shirt: http://www.brendangregg.com/perf_events/omg-so-perf.jpg

Maybe we should ask Linus to come with some other nice, short,
searchable, funny name like 'git'?

'chob' as in 'check object'?

- Arnaldo
