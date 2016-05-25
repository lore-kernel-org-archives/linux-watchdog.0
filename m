Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33915 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEYVAM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 17:00:12 -0400
MIME-Version: 1.0
In-Reply-To: <20160511105224.GE2749@pathway.suse.cz>
References: <1460646879-617-1-git-send-email-pmladek@suse.com>
	<20160422183040.GW7822@mtj.duckdns.org>
	<20160511105224.GE2749@pathway.suse.cz>
Date: Wed, 25 May 2016 16:42:04 -0400
Message-ID: <CAOS58YP101zopOfTSUYNRN4Jk3Ts_47+DFXVam0KGbr8OtaF4g@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] kthread: Use kthread worker API more widely
From: Tejun Heo <tj@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>,
	Michal Hocko <mhocko@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Linux API <linux-api@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
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
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 11, 2016 at 6:52 AM, Petr Mladek <pmladek@suse.com> wrote:
> Tejun, may I add your ack for some of the patches, please?
> Or do you want to wait for the resend?

When you repost, I'll explicitly ack the patches.

Thanks!

-- 
tejun
