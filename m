Return-Path: <SRS0=BrKj=UM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0FCC31E4B
	for <linux-watchdog@archiver.kernel.org>; Thu, 13 Jun 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61368208CA
	for <linux-watchdog@archiver.kernel.org>; Thu, 13 Jun 2019 15:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfFMPri (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:47:38 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:39812 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbfFMJ2H (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 13 Jun 2019 05:28:07 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id EE37725B7FA;
        Thu, 13 Jun 2019 19:28:04 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id EF87E940483; Thu, 13 Jun 2019 11:28:02 +0200 (CEST)
Date:   Thu, 13 Jun 2019 11:28:02 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nguyen An Hoan <na-hoan@jinso.co.jp>,
        linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        wsa+renesas@sang-engineering.com, kuninori.morimoto.gx@renesas.com,
        yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp,
        cv-dong@jinso.co.jp
Subject: Re: [PATCH] watchdog: renesas_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Message-ID: <20190613092802.yxeredwczrcta4tp@verge.net.au>
References: <1558603778-20848-1-git-send-email-na-hoan@jinso.co.jp>
 <1558603778-20848-2-git-send-email-na-hoan@jinso.co.jp>
 <20190607173152.GA14638@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607173152.GA14638@roeck-us.net>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Jun 07, 2019 at 10:31:52AM -0700, Guenter Roeck wrote:
> On Thu, May 23, 2019 at 06:29:38PM +0900, Nguyen An Hoan wrote:
> > From: Hoan Nguyen An <na-hoan@jinso.co.jp>
> > 
> > Add helper variable dev = &pdev->dev
> > 
> > Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

