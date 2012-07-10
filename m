Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46106 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab2GJLlk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Jul 2012 07:41:40 -0400
Subject: Re: [PATCH 2/2][v2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with CONFIG_PPC_FSL_BOOK3E
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AFA5C641-783C-4B61-ACCF-6A776BF75B24@kernel.crashing.org>
Date: Tue, 10 Jul 2012 06:41:32 -0500
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: 7bit
Message-Id: <20BD2018-DAEA-4FBD-AC79-B5C1FC10DE92@kernel.crashing.org>
References: <1336714420-2394-1-git-send-email-Shaohui.Xie@freescale.com> <ED492CCEAF882048BC2237DE806547C9079802C6@039-SN2MPN1-013.039d.mgd.msft.net> <AFA5C641-783C-4B61-ACCF-6A776BF75B24@kernel.crashing.org>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Jul 10, 2012, at 6:40 AM, Kumar Gala wrote:

> 
> On Jul 10, 2012, at 5:22 AM, Xie Shaohui-B21989 wrote:
> 
>> Hi, All,
>> 
>> Is there any concern for this patch, it's been a long time.
>> Thanks!
>> 
>> 
>> Best Regards, 
>> Shaohui Xie 
> 
> As commented, we should use PPC_FSL_BOOK3E, not CONFIG_PPC_FSL_BOOK3E.
> 
> - k

Sorry, was looking at the older version of this patch.

- k
