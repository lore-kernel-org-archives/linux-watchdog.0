Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36735 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbcBLKlL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Feb 2016 05:41:11 -0500
Subject: Re: [PATCH 00/33] Compile-time stack metadata validation
To: Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <cover.1453405861.git.jpoimboe@redhat.com>
 <56BDB5A8.9030006@suse.cz>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
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
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <56BDB6C2.4050205@suse.cz>
Date: Fri, 12 Feb 2016 11:41:06 +0100
MIME-Version: 1.0
In-Reply-To: <56BDB5A8.9030006@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/12/2016, 11:36 AM, Jiri Slaby wrote:
> It there some compilation flag missing? -f flags when compiling that file are:
> -falign-jumps=1
> -falign-loops=1
> -fconserve-stack
> -fno-asynchronous-unwind-tables
> -fno-common
> -fno-delete-null-pointer-checks
> -fno-inline-functions-called-once
> -fno-omit-frame-pointer
> -fno-optimize-sibling-calls
> -fno-strict-aliasing
> -fno-strict-overflow
> -fno-var-tracking-assignments
> -fstack-protector
> -funit-at-a-time

Happens with:
gcc (SUSE Linux) 5.3.1 20151207 [gcc-5-branch revision 231355]
gcc-6 (SUSE Linux) 6.0.0 20160202 (experimental) [trunk revision 233076]

> thanks,
-- 
js
suse labs
