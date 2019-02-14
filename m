Return-Path: <SRS0=mhZ9=QV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072ECC10F04
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Feb 2019 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B3C2229F
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Feb 2019 22:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db0OTrcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395262AbfBNWKh (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:10:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40654 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395218AbfBNWKh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 14 Feb 2019 17:10:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so223407pgo.7;
        Thu, 14 Feb 2019 14:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+G+/Tv/LVVp5yMCM79O8zHJHRh/fMf3ed9bvKVaV2s=;
        b=Db0OTrcq+ijfzq0DaoCnfOeexl9qsgSFd0K6RVyAzIOV0BPLXb0y8ogl06IQB/l9Qm
         pIG8eoj2w/9ZWBypzC95VD8kBFresusjM6naP5BbpwXiTOqPAtbFEg7yz0kS8E6IDLnA
         vwO7u/gSzp5tGaZvynNTL1NgUFr6PpqDRCDeLbFOlRJdYDhnuzZsJGkh7o0PHsJsU/Zg
         ysVq22MQJ3jyfLJMjumyI5Ue0BbV2S3nBUeAbfz8+n9mmnlEi7um5o2A7vMXqfxlWPix
         GXi+kHuVEfTWte4lJzAcUDRBq2cL1a8V55V4Cva3k9Xgp0X3loQO5nLRSDvQtKSjxsAj
         /AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+G+/Tv/LVVp5yMCM79O8zHJHRh/fMf3ed9bvKVaV2s=;
        b=WzWYw7VZdim3SDTwcLLpV2s8Sa/L1sX9YWoSRbCvqzdvXQdWlp/VgBdnOtLmw4qhKv
         B4VKROwBAuzaoy7yF8WFjMEdvfeYzMwVHfRQqBo/LpVHQf85HN6aQcC9Xz20U1pypNyb
         KKr0VUS4HsGHw0yj2brRiXtX82cvM72jNOIMIYa7md8+LNVKE/Z9sOJbe+aE5Mvs8bxc
         OjouDLTGkTb1dTjQ41TPKT/69Oa8wT+Mt6/FZohXp1dKEBesv16cB0eGOfaMNt1064It
         woOPgZVkm8cBx8AZWlZeRnKPX/kXVDAC+JtDqpN/c7ADt7cpyQQFiEBL7CjJSHfBvK+z
         ptLQ==
X-Gm-Message-State: AHQUAubydnWZDl4sjCMBqOrH6kj9Bf7zmLOrYoktA+hc3dCLKLRuK1tM
        dIUCrlfScz3c2nAMx2gMt+c=
X-Google-Smtp-Source: AHgI3IZ8r++IG+KgY1MV736iiTE+NNe7hhgMxlyHKv6aRMBfZ4JrMJDxHQVoSGqccx1XEViX6PXgdQ==
X-Received: by 2002:a62:1d8c:: with SMTP id d134mr6459874pfd.96.1550182236411;
        Thu, 14 Feb 2019 14:10:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t185sm1608137pfb.114.2019.02.14.14.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:10:35 -0800 (PST)
Date:   Thu, 14 Feb 2019 14:10:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Mehrtens, Hauke" <hauke.mehrtens@intel.com>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: print active stack on watchdog pre timeout for separate irq stack
Message-ID: <20190214221034.GA11494@roeck-us.net>
References: <9231D502B07C5E4A8B32D5115C9F19991F89C484@IRSMSX108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9231D502B07C5E4A8B32D5115C9F19991F89C484@IRSMSX108.ger.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, Feb 14, 2019 at 09:27:17AM +0000, Mehrtens, Hauke wrote:
> Hi,
> 
> We would like to print the stack of the currently active kernel thread from the interrupt handler when the watchdog pre timeout interrupt for our watchdog is triggered, currently we have a WARN_ONCE() in the code of the interrupt handler, but this only prints the interrupt stack, which is pretty boring. On MIPS the interrupts are handled on a separate stack and not on top of the stack of the current active kernel thread to avoid stack overflows. Is there some function which would print the stack trace of the current active kernel thread in addition or instead of the interrupt stack inside of an interrupt?
> 
> The kernel also has these pre timeout handlers, but they also seem to be affected by this problem:
> https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/watchdog/pretimeout_panic.c
> 
Not sure I understand. Are you saying that panic() doesn't help either ?
If that is correct, I have no idea what else could be done.

Guenter
