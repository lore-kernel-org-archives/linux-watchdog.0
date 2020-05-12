Return-Path: <SRS0=vmV8=62=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE947C54E8E
	for <linux-watchdog@archiver.kernel.org>; Tue, 12 May 2020 01:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD0120757
	for <linux-watchdog@archiver.kernel.org>; Tue, 12 May 2020 01:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589248553;
	bh=HdIAKfnBTFojHJGuC52K1mTk4Ff7SYELOpeOB5THexY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uMjCK/trSmN46qvzn4JB1hncDY2y8RJaow+9vbzOPc8pSGcfyooQbYFu7Eo7PBj6t
	 CuhVPlCfgmDCfLlhRUxrDvZu3oG40g0ocRjE4hUwuVVZAADz6nM92X3CUL1XjXMIFw
	 eO09NhOE/dy7RhCXZyeFkIFPVYVsN34nshtfrutM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgELBzx (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 11 May 2020 21:55:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44024 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgELBzw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 May 2020 21:55:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id i22so326294oik.10;
        Mon, 11 May 2020 18:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvdkDjJgHkrJZAXxe7kWW2KoCcBgrdBf6jVKJaBJ6eA=;
        b=eY3LNzUVNTQ6K55bVVQI/hl0twR1b1BrLOt8IJzjIwlBkxPSpFcV+hs9XmToU21iLr
         xYMR4m50z5/1iRy+a0Zjp9ydBgTRMtOpGQ/ErHvPI1j6xWN+9FtZJ01wWA/3hVLO5ydi
         jxtPStWTR5o9IDTvj8bkl+ULi01gOsmEx62W+cmkza9s2uTIgu5pek+SJ7U4FAT819C2
         yJ86NdtRxA79tqO9xHeWl35L6zGGO8hQGq1ijSFPCHene6GwJOyAu9avymIUYNq6G/rf
         un3yvsMqx4mHQvh1Fq0ZIC6cR7fI9pe29MCqeSlQINXchN0qaAIZNyncaUXmETrYyMK4
         zLZA==
X-Gm-Message-State: AGi0PuYcOupDUvDRM6jDK+fApbzw8AIhoPAuMUA1s1Gqc1O03yrokPtP
        Ax6qThFqo/lXW777s2Ic1n27CcA=
X-Google-Smtp-Source: APiQypIsMqWXRJ9XFZUYo9p1IXs09K3ln70URcV3ZiM6cvIVUuwsR8fyZSDYwIaBpJFjJ6eGs4Ibhw==
X-Received: by 2002:aca:3788:: with SMTP id e130mr20536712oia.3.1589248551931;
        Mon, 11 May 2020 18:55:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l8sm374107otr.7.2020.05.11.18.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 18:55:51 -0700 (PDT)
Received: (nullmailer pid 18064 invoked by uid 1000);
        Tue, 12 May 2020 01:55:50 -0000
Date:   Mon, 11 May 2020 20:55:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Convert to
 json-schema
Message-ID: <20200512015550.GA17994@bogus>
References: <20200427192522.28365-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427192522.28365-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, 27 Apr 2020 21:25:22 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas Watchdog Timer (WDT) Controller Device Tree binding
> documentation to json-schema.
> 
> Add missing "renesas,r8a77980-wdt" compatible value.
> Document missing properties.
> Update the example to match reality.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/watchdog/renesas,wdt.txt         |  50 ---------
>  .../bindings/watchdog/renesas,wdt.yaml        | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> 

Applied, thanks!
