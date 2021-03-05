Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8536EC433DB
	for <linux-watchdog@archiver.kernel.org>; Fri,  5 Mar 2021 05:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5186A65018
	for <linux-watchdog@archiver.kernel.org>; Fri,  5 Mar 2021 05:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCEFVF (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 5 Mar 2021 00:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEFVE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 5 Mar 2021 00:21:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FBF465015;
        Fri,  5 Mar 2021 05:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614921664;
        bh=AJg1FGKznu9BtYd76Gqv/R51O41xFt8MvX0qOxmPt4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mste6ltr1wOLT1aouWjZN0lLBH7fxUaOtbK4v3UAttUy2K6NhaX+8vYnWAFevWZQd
         2i3zEaU6D+HNKjci3QrbaduXfWwJwzPKBzSCba25vuRdLPNc/xnt6CzjLYer/BZ2OZ
         E/P6Wc1oDx94pa8GVA4UoEhWb/FzK1CRMCOpvQ53mKGbkiS9C9DfV5x/M5p6J4XsYT
         k43xe/7dp1jb0QUbrZrRtglsiXg49rxINXEvI0JG0WMVf0JBPtb+wLRQV6rKh97vDJ
         AF0wIF74zGv7v1Lr5kAJB5EbSFFao+XH8Sb6zZWtPgG1h0VL5z2K5qhODXEC/aCXqY
         v7mBQf2nyK11g==
Date:   Thu, 4 Mar 2021 23:21:02 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 057/141] watchdog: Fix fall-through warnings for Clang
Message-ID: <20210305052102.GA113683@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <713aa26be06d50dd3bb582a3cb71f04787ad5d5b.1605896059.git.gustavoars@kernel.org>
 <20210304230406.GA106291@embeddedor>
 <20210305041512.GA154288@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041512.GA154288@roeck-us.net>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, Mar 04, 2021 at 08:15:12PM -0800, Guenter Roeck wrote:
> On Thu, Mar 04, 2021 at 05:04:06PM -0600, Gustavo A. R. Silva wrote:
> > Hi all,
> > 
> > It's been more than 3 months; who can take this, please? :)
> > 
> 
> I am not in favor of cosmetic patches for old drivers,

Me either. However, this is not a cosmetic patch[1].

> and I am not going to provide tags for them anymore.
> The driver should be converted to use the watchdog core,
> or it should be dropped.

Is it OK with you if I carry this in my tree for a future pull-request
to Linus?

Thanks!
--
Gustavo

[1] https://github.com/KSPP/linux/issues/115
