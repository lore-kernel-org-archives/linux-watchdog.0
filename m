Return-Path: <SRS0=4yGa=6Z=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85167C54E4B
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 May 2020 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A8F206E6
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 May 2020 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589223553;
	bh=AFGGGfTe4KqGnc7spc3MaphhEeHUOahSgz4oLXYWSBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u2jkxp/vX1pZrORT5krWpZXpTwsGT9GX1CHd7x+PXVENFDiTFT8JcVerYbahBnM3b
	 aa0+Snu81Ft5tCmyAP/4H1/ekW3XSL0a/ZV6b1SBG1JyKViO55n4ZqKFdkrctUlmF0
	 EabvfD4gjkNp/sY+CzCXa0a7pvuLSKwUF1QMY/yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgEKS7K (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 11 May 2020 14:59:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40029 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbgEKS7J (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 May 2020 14:59:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id t199so16088788oif.7;
        Mon, 11 May 2020 11:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzGSAEhMRCQmh/uukdsZU1Wyq2X3cZKWLbb3M9w2uU0=;
        b=dACHxc8MPylaYGzC+77nxGwEpnWZzMCyR5+Lzsa+HB3kLXkqgRk93F3Dw1uSbRc2gr
         wENQGkv9I9W8gdh8qw/PZ5L8Sfh1lfUBd5fBEKlUizOhMCvrDd5WaQfqNnKgt4CaeY+H
         WN6EbkTtDgFl1P7hJd59RCHHluMnb2hJT7Y87s0Hoqzu3QgmFP/Joa37g9thGYQ3/acl
         Q2NuCoYjZN/uVfWgg7JBDNRqdzk1uiLaWeLwYSNo0aWT1n9b7RuYTC4HKRnHxvF2BE8m
         z40jsD/hsCOhClRzyVlncWIY7xX31KZ88OuEM9oQzk+J+xUKSwRqX9IaqXsz2h3pfpgx
         WSvg==
X-Gm-Message-State: AGi0PubxFJbH/OSGD9Hp4UVv1ZBNxKMB51r0pFoRvaB+78i1QPsclFlJ
        Au9oNA96qkRSbpEJKbT1/4glULQ=
X-Google-Smtp-Source: APiQypJLwE5G8HTFSG69tUK6PQXc+J8y9iArzf1DlACKjlE2ctk9cwX64/nmHhxnbfrSW2cG7UluYA==
X-Received: by 2002:aca:ac84:: with SMTP id v126mr21321792oie.132.1589223548934;
        Mon, 11 May 2020 11:59:08 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 10sm2835605oto.80.2020.05.11.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:59:08 -0700 (PDT)
Received: (nullmailer pid 5979 invoked by uid 1000);
        Mon, 11 May 2020 18:59:06 -0000
Date:   Mon, 11 May 2020 13:59:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@roeck-us.net, s.hauer@pengutronix.de, wim@linux-watchdog.org,
        festevam@gmail.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: watchdog: Convert i.MX to json-schema
Message-ID: <20200511185906.GA5896@bogus>
References: <1587478886-21512-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587478886-21512-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, 21 Apr 2020 22:21:25 +0800, Anson Huang wrote:
> Convert the i.MX watchdog binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- drop clocks description;
> 	- drop unused label.
> ---
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   | 24 ----------
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml  | 54 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> 

Applied, thanks!
