Return-Path: <SRS0=6lbm=RK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B8C43381
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Mar 2019 06:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10E520835
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Mar 2019 06:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6wxzGcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCGGjs (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:39:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfCGGjs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 7 Mar 2019 01:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vVXhddLxtvrnq2lqtkQ9Cazk8jnozWKOihu5vLtpdoA=; b=l6wxzGcVUA4R7vr63YNRso7DF
        2RA5xm9v62pcTXlfAVHF+znqKKoSzX2aONTZwNepn9Blj6nVri0c/7GiQlVH/Ubu9xnwBAwBFvy2h
        7YRpTaF/zTWUzwiwUXrk0eAVtarXywrNn5/+Jhk+m2NOZ+upB2QVAnjtXCxTMKcR5b7gxeIIOaoST
        oV68wciV55Kgox74JrNuuPbT8QuzbFV4LfaZ39zUIG1mqseaNzhxE0gWSK+acNBFIglCzibfAqdwe
        JNUBYnELtzR8Zv2Uc6XpY7h0+Jt95kd50vO0DWA44Bu1rfflJ6Z45zLXntHlftxfgnxXuu3xrBj5J
        to6/0AlDA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1mgw-0004zo-AY; Thu, 07 Mar 2019 06:39:42 +0000
Date:   Wed, 6 Mar 2019 22:39:40 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michael Shych <michaelsh@mellanox.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] watchdog: mlx-wdt: introduce a watchdog driver
 for Mellanox systems.
Message-ID: <20190307063940.GH44339@wrath>
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-3-michaelsh@mellanox.com>
 <a93993bf-cf72-83c0-0d44-d8f46230482c@roeck-us.net>
 <AM6PR05MB522419E0EF2BD6098A00FB8EA2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
 <f6038e0f-107d-f04f-af5c-e7fd822f8436@roeck-us.net>
 <AM6PR05MB52241830B0F86C68BC78F0D2A2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR05MB52241830B0F86C68BC78F0D2A2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sun, Feb 24, 2019 at 06:01:46PM +0000, Vadim Pasternak wrote:
...
> > > Who should take it to the next, watchdog or platform mainatainer?
> > >
> > Good question. For now I added it to my watchdog-next branch. But then strictly
> > speaking (and as far as I know) we don't have an Ack from the platform
> > maintainer, so maybe I should not have done that. Maybe we should wait for
> > the platform part to be merged by the platform maintainer. Thoughts, anyone ?
> > 
> 
> Right.
> 
> Darren, Andy,
> In case you are OK with the changes in mlxreg.h from
> [PATCH v4 1/3] platform_data/mlxreg: additions for Mellanox watchdog driver.
> from this patchset, could you please ack?

I don't have any problem with the change as proposed. We do appear to
have a conflict in next now though. So we either have to provide merge
instructions to Linus, or rebase the wdt next branch and have us pull it
in.

I'd prefer to leave things alone, keep the series together in the wdt
next tree, and just provide Linus with an explanation of the merge
conflict (standard operating procedure).

So, a bit late, but for the record, for the mlxreg.h changes:

Acked-by: Darren Hart (VMware) <dvhart@infradead.org>


-- 
Darren Hart
VMware Open Source Technology Center
