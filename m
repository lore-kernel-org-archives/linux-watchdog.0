Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41765 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbcEKKw3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 May 2016 06:52:29 -0400
Date: Wed, 11 May 2016 12:52:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>,
	Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-watchdog@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	linux-rdma@vger.kernel.org,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-pm@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v6 00/20] kthread: Use kthread worker API more widely
Message-ID: <20160511105224.GE2749@pathway.suse.cz>
References: <1460646879-617-1-git-send-email-pmladek@suse.com>
 <20160422183040.GW7822@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160422183040.GW7822@mtj.duckdns.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri 2016-04-22 14:30:40, Tejun Heo wrote:
> Hello, Petr.
> 
> On Thu, Apr 14, 2016 at 05:14:19PM +0200, Petr Mladek wrote:
> > My intention is to make it easier to manipulate and maintain kthreads.
> > Especially, I want to replace all the custom main cycles with a
> > generic one. Also I want to make the kthreads sleep in a consistent
> > state in a common place when there is no work.
> > 
> > My first attempt was with a brand new API (iterant kthread), see
> > http://thread.gmane.org/gmane.linux.kernel.api/11892 . But I was
> > directed to improve the existing kthread worker API. This is
> > the 4th iteration of the new direction.
> > 
> > 1nd..10th patches: improve the existing kthread worker API
> 
> I glanced over them and they generally look good to me.  Let's see how
> people respond to actual conversions.

The part improving the kthread worker API and the intel powerclamp
conversion seem to be ready for the mainline. But it is getting too late
for 4.7.

I am going to resend this part of the patch set separately after
the 4.7 merge window finishes with the aim for 4.8. The other
conversions are spread over many subsystems, so I will send
them separately.

Tejun, may I add your ack for some of the patches, please?
Or do you want to wait for the resend?

Andrew, I wonder if it could go via the -mm tree once I get
the acks.

Best Regards,
Petr
