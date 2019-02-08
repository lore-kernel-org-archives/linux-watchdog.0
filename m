Return-Path: <SRS0=d5Mv=QP=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D099C169C4
	for <linux-watchdog@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD9820857
	for <linux-watchdog@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG+RcCNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfBHOFr (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:05:47 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36917 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHOFq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 8 Feb 2019 09:05:46 -0500
Received: by mail-pl1-f177.google.com with SMTP id b5so1752514plr.4
        for <linux-watchdog@vger.kernel.org>; Fri, 08 Feb 2019 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ju152MoD316PYp1DDvx8Ad8Da7wpcVuRBQgZvFQVTKc=;
        b=gG+RcCNrenvdRy6jV0goeiNih1IxGxn3UCNPDHDvb+BMKc7ihfX9ScbgVwi28MUJvn
         /jWaIUie2RaQBvAJnYzfoM6FEiDvuspURyMt0GLalyWW7sSeCSK4C+RlFaENS7MT7tbR
         H+vsTeTW7h2L4ii1fY0w4DyKaSXvtK/DK9ozYHRfCco+kVdGJBf9fm7beppkTT9TLMNQ
         MTdye5Goa/+bplFvnYAWjaPJC9mA3aWG5BqeyxqSbUy0jGxE6ZB8y04O8VcmdfCj2jqF
         PM3H9+OUpU4e4GrIz3reZq75+JmWACJNtzfVC2hbg7Li+loIrR9E8tySl5kXQIuiP1Tv
         jF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ju152MoD316PYp1DDvx8Ad8Da7wpcVuRBQgZvFQVTKc=;
        b=E3EHTiY+keVOhfy9Qqgpkh87Pq9buT2yGHixUkHTNw97Yg5QW+JCJEpVZxErcRoAd3
         6NliSu6pgA7FBboWy5iwdsUyjKJxIPyJscwBs8j1qCSliV91FeGejy9btsh/d7+yB1EP
         5TQ4x6cmhnly+3ee/fKSImj8J0Ml8csZHK2oUpDlrbrlFJ5wUKgXe8bKYkI4pw/xbgs6
         I1KsYwPT0sNuT78Y4Rcfm+/Y/dQ/Gv7qAAdDIoSlNUksAVUJjafEQOzImbTGPptsIj/7
         51+PgZ7nAJ0o7ThzmmAhYxSCEPkRubRHTgrLSvfnRzCG/HG+6rHymrfD69uAMCO48NgO
         pK0A==
X-Gm-Message-State: AHQUAuZ6ot8dF97Lx1lIcurh0yeo0oTHsZ/vhBdRQecLXZI1ARVplRHy
        UkGzyZYCY2QRHeyNv7ixReX2d44G
X-Google-Smtp-Source: AHgI3IZff5ekWZlZ6k1AjXA5mpI2OdM+MZIEzOkar3Tug8C/A6Imt7dJRCwZtvS4pOm11/fftClieQ==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7mr1606051plq.130.1549634746020;
        Fri, 08 Feb 2019 06:05:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v184sm2768090pfb.182.2019.02.08.06.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:05:44 -0800 (PST)
Subject: Re: What to set in struct watchdog_device::bootstatus?
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org
References: <20190208105230.g33nxiu4r6uqech3@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f9ec94d7-8365-e733-81ff-34c501cce89a@roeck-us.net>
Date:   Fri, 8 Feb 2019 06:05:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208105230.g33nxiu4r6uqech3@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/8/19 2:52 AM, Uwe Kleine-König wrote:
> Hello,
> 
> it's unclear to me, which bits I am supposed to set in the bootstatus
> member of struct watchdog_device at probe time.
> 
> The i.MX watchdog differentiates the following reset causes:
> 
>   - Power On
None.

>   - external reset

None.

>   - watchdog timeout

WDIOF_CARDRESET

>   - software reset using a bit in the watchdog register set
> 
> (Not all i.MX variants implement all bits according to the respective
> reference manuals.)
> 
> Should "Power On" result in setting WDIOF_POWERUNDER?
> 
No.

> Should "software reset [...]" result in WDIOF_CARDRESET?
> 
That would be the best fit if you want a bit to be set, but it would be
misleading since it would suggest that the watchdog fired.

> Should "external reset" result in WDIOF_EXTERN1? (I guess that no)
> 
No.

Overall, the bits are only to be set if the reset was triggered by
the watchdog controller.

Guenter
