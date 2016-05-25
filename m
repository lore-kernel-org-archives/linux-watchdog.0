Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www262.sakura.ne.jp ([202.181.97.72]:41768 "EHLO
	www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbcEYV5A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 17:57:00 -0400
Subject: Re: [PATCH v6 13/20] hung_task: Convert hungtaskd into kthread worker
 API
To: Petr Mladek <pmladek@suse.com>
References: <1460646879-617-1-git-send-email-pmladek@suse.com>
 <1460646879-617-14-git-send-email-pmladek@suse.com>
Cc: Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	linux-watchdog@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <47fb67eb-1756-7189-0245-f59c5a4c5f41@I-love.SAKURA.ne.jp>
Date: Thu, 26 May 2016 06:56:38 +0900
MIME-Version: 1.0
In-Reply-To: <1460646879-617-14-git-send-email-pmladek@suse.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2016/04/15 0:14, Petr Mladek wrote:
> This patch converts hungtaskd() in kthread worker API because
> it modifies the priority.
> 
> This patch moves one iteration of the main cycle into a self-queuing
> delayed kthread work. It does not longer check if it was called
> earlier. Instead, the work is scheduled only when needed. This
> requires storing the time of the last check into a global
> variable.

Is it guaranteed that that work is fired when timeout expires? It is
common that tasks sleep in uninterruptible state due to waiting for
memory allocations. Unless a dedicated worker like vmstat_wq is used
for watchdog, I think it might fail to report such tasks due to all
workers being busy but the system is under OOM.

  vmstat_wq = alloc_workqueue("vmstat", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);

