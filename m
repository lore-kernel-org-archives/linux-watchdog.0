Return-Path: <SRS0=7ngW=PM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9FC43387
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Jan 2019 13:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83B22070C
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Jan 2019 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JNWkitOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfADNL6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:11:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:33907 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfADNL6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Jan 2019 08:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0uU4ErMfrHybZu3wFI6q20fJ9EtlBFP4yAeEfb88eh8=;
        b=JNWkitOv8CAO28ZlI+MwVHgyaT0Qsu/LzugFdRV63OfH5AZhTwMG0AhK6rSuRsELV0YxE5s5X834HiCGbhTV7JS/qG5zyk8GFccB6vKN6qXBUlSNo9NOSvYeGvQpiDTCHf2DFoR92mBwq8mtV1kITVUPPoc8PvhZvkdj50Hfzdo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gfPGM-00034D-8i; Fri, 04 Jan 2019 14:11:46 +0100
Date:   Fri, 4 Jan 2019 14:11:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] watchdog: tqmx86: Fix a couple IS_ERR() vs NULL bugs
Message-ID: <20190104131146.GA11435@lunn.ch>
References: <20190104064725.GC30627@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104064725.GC30627@kadam>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Jan 04, 2019 at 09:47:25AM +0300, Dan Carpenter wrote:
> These functions return NULL on error but we accidentally check
> for IS_ERR() instead.
> 
> Fixes: e3c21e088f89 ("watchdog: tqmx86: Add watchdog driver for the IO controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
