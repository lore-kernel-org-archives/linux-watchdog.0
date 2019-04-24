Return-Path: <SRS0=EMH8=S2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51558C10F11
	for <linux-watchdog@archiver.kernel.org>; Wed, 24 Apr 2019 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170AD20684
	for <linux-watchdog@archiver.kernel.org>; Wed, 24 Apr 2019 21:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbEr7qKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbfDXVFe (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:05:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42689 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbfDXVFe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 Apr 2019 17:05:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so5539419pln.9
        for <linux-watchdog@vger.kernel.org>; Wed, 24 Apr 2019 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=il6ycxi2Rrgs6wrucfUPNPx9uE1Usza7hgd30agoiaw=;
        b=pbEr7qKN1Klbk/cLzbogbkt1PL1ykqN57fyNSq2WVle/n3qk1UKFeAZXu+lb53IEUZ
         Z+bEJwqGkVactvCgd6EN+gSAcg9LPbKHLLDPkJXXDVWQYNzZB5MFQnsU/dRtjxmkrQpT
         ARxBKwLF+umEbaDXXfvGuorAFfAsS/p4/T5dcrJC2meL24M93/udWeM2/U8Bwa35bIK0
         3Y5wHzjah+Asy9+IKda5EsqPgTObd1ygVqSsUwvNaeCpGwWJM17aTZmnL5aGZgpaoWfn
         cKhg6duYvvxVEiUncxa3/gWvjMc4Ba57i1Ikqg9lC6iowytKd8plpP022Of+yP4fzTvS
         XKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=il6ycxi2Rrgs6wrucfUPNPx9uE1Usza7hgd30agoiaw=;
        b=d9S6wtRYLbJbgttiJDy21UrPJGdXi9YG3oNKlmiIqvNca1a8Sa7m/yRCVtziJOIUCM
         ZUy9zJTyF+otSls/mqTWtiZKrWyoKC55mwcEOLVSQwJ8NG7d7j7lNOHXagWXfJvfyJPc
         gjQfB5w5RPs4Qh9u66LTCH5uE4pB8jISiUacbDuQHiS2CufgmTtVFz/9Em4tpBA7VcW/
         dbH7UokYQTZlrh8FOK4UofNt7g3Z5jCdiZKobA5/dbtUWMK11Uyxqa+7MRjnc1QZCPJg
         p9Pz7kDry/taMKrJdDR40DS9a9Pz+0ZOOtp94NuYOT7VjmPIfLvQW45bkCFeg6JgjiKo
         O0Dg==
X-Gm-Message-State: APjAAAUxPaVcUdxErSX+LX3T81iFsL7FaPVKkpavZzg3h356O1xOro2J
        jRNgeaSZVGBMf4vzD3Xc2KM=
X-Google-Smtp-Source: APXvYqwXwWCfodDI2o4qRX6HfUOsQIehlgIaCZWI2WBZUtON/iGDU5t9o38FTeMxUs+wecPPjSbYIg==
X-Received: by 2002:a17:902:7205:: with SMTP id ba5mr13116681plb.285.1556139933678;
        Wed, 24 Apr 2019 14:05:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d38sm23886008pgd.40.2019.04.24.14.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:05:32 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:05:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly
 non-modular
Message-ID: <20190424210530.GA29993@roeck-us.net>
References: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
 <1556034515-28792-3-git-send-email-paul.gortmaker@windriver.com>
 <439d89d7-bae6-c5c8-e9bf-5477304bc065@roeck-us.net>
 <20190424153700.GT23044@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424153700.GT23044@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Apr 24, 2019 at 11:37:00AM -0400, Paul Gortmaker wrote:
> [Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly non-modular] On 23/04/2019 (Tue 18:22) Guenter Roeck wrote:
> 
> > On 4/23/19 8:48 AM, Paul Gortmaker wrote:
> > >The Kconfig currently controlling compilation of this code is:
> > >
> > >config WATCHDOG_CORE
> > >        bool "WatchDog Timer Driver Core"
> > >
> > >...meaning that it currently is not being built as a module by anyone.
> > >
> > >Lets remove the modular code that is essentially orphaned, so that
> > >when reading the driver there is no doubt it is builtin-only.
> > >
> > >We replace module.h with export.h since the file does export some
> > >symbols.  We don't add init.h since the file already has that.
> > >
> > >We also delete the MODULE_LICENSE tag etc. since all that information
> > >is already contained at the top of the file in the comments.
> > >
> > 
> > I must admit that I am not at all happy about this change. While not
> > configurable by default, I used tristate a lot (after enabling it
> > manually) to test watchdog core code while changing it. It saves a
> > lot of time to be able to reload the watchdog core without having
> > to reboot the entire system after each change. Removing the ability
> 
> I'm confused.  If it is useful, then why not formally make it tristate
> so other people can do the same as you do, and nobody is manually making
> the change over and over again each time?  I'd support that update.
> 
No idea. That precedes my involvement in the watchdog subsystem.
Let's wait for input from Wim. I have a set of patches ready, but it
doesn't make sense to me to submit them if Wim wants to go the non-modular
route.

FWIW, I am fine with the other patches except for the npcm patch, because
several of the other npcm drivers are buildable as module.

Guenter
