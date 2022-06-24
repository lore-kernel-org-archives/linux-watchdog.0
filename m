Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A826DC433EF
	for <linux-watchdog@archiver.kernel.org>; Fri, 24 Jun 2022 13:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiFXNvH (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXNvF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Jun 2022 09:51:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A614CD4E
        for <linux-watchdog@vger.kernel.org>; Fri, 24 Jun 2022 06:51:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTz6Z3qClz4xYN;
        Fri, 24 Jun 2022 23:51:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1656078662;
        bh=oTQkrMVJjt9EFA7jY/+HvD1PmcUsgMzdT0WBxm7qFlY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jb0pkru7qVZfM+PMt4Dfr8VurMJOHeRAvPY/uMveLTYz8umtAmiPooaZ4r6A4t75D
         HA64ybK+kKyblBE7WWPVNNU8oO69dShg+HZmwBX88SZK0eTE4V03DM21hgiQYeSI5i
         8paJdPjkhd9KLJZLsgtGXsIPJ/WYnYqU+sd5yQSyzA38UasOgElq4HYg5ttJpfVzvs
         Q7T449bRU7TCc02MfCzoAVeALni7QZ789IHre0E73JZpxNDuJRzZC6dqqOnXlevzLS
         x4gpDvbdkYfnFurJix/orIJSY6U7F+ikDR8sw/ejL2vgkxPoJCjsMzdeuH4MDd8PFG
         hhnvXFVEnHjCQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Scott Cheloha <cheloha@linux.ibm.com>,
        linux-watchdog@vger.kernel.org
Cc:     nathanl@linux.ibm.com, wvoigt@us.ibm.com, aik@ozlabs.ru,
        Scott Cheloha <cheloha@linux.ibm.com>, vaishnavi@linux.ibm.com,
        npiggin@gmail.com, tzungbi@kernel.org, brking@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
Subject: Re: [PATCH v2 4/4] watchdog/pseries-wdt: initial support for
 H_WATCHDOG-based watchdog timers
In-Reply-To: <20220602175353.68942-5-cheloha@linux.ibm.com>
References: <20220602175353.68942-1-cheloha@linux.ibm.com>
 <20220602175353.68942-5-cheloha@linux.ibm.com>
Date:   Fri, 24 Jun 2022 23:51:01 +1000
Message-ID: <87sfnu41bu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Scott Cheloha <cheloha@linux.ibm.com> writes:
...
> +
> +static struct platform_driver pseries_wdt_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,

That owner assignment is not required.

It's set for you by platform_driver_register() via
module_platform_driver().

cheers
