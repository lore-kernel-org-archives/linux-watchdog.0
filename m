Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0EAC48BE5
	for <linux-watchdog@archiver.kernel.org>; Tue, 15 Jun 2021 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4A061581
	for <linux-watchdog@archiver.kernel.org>; Tue, 15 Jun 2021 14:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFOOxX (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFOOxX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Jun 2021 10:53:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15F7E61462;
        Tue, 15 Jun 2021 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623768678;
        bh=vDbh+QHaCgHV8scKgUtS1UV8VvO2KDFM9N+Yb9Kup+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bf4J9YFC7uJqBTxr3pYqt5fAWvYPVRjGGl20WeZMJs6P9R49Ep/2rdWl3jHAdzfap
         PDQXx3YsEKjkacx45fxdQb0GE2qiUp2fvi4xF1hKyP8C6YkqBHrhYu6RFo7KAsBPo4
         bNUgA6q1DTrpVBnoCq16qRH4kF0v6au/W2aFghkdFBJdqupIJWfW6nEmxOo73bmwLo
         Q+Dt7cHDivB7i16qjTXxryPU6cbqr99Ti0lm2co6Fr1P7fiNnGFQRB/lmqykkP+TiN
         msfISypr5cSGz1ifbO6lmOeZTiFgQopkqhoGiS1nkscQJxo4M7uXoI6bzapy7OcfIk
         tScakGo3tBl/A==
Date:   Tue, 15 Jun 2021 09:51:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: iTCO_wdt: use dev_*() instead of pr_*()
 for logging
Message-ID: <20210615145116.GA2879841@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4ea22d-a97c-b803-134c-751cb648f5f7@metux.net>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Jun 14, 2021 at 07:55:24PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 10.06.21 01:54, Guenter Roeck wrote:
> 
> > The above came in with a recent commit. I suspect they simply got lost,
> > and they should be converted as well.
> 
> Since I might need to touch it again in near future, I'll do it in
> one of the next rounds.

Thanks!
