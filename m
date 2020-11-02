Return-Path: <SRS0=opv0=EI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF4C00A89
	for <linux-watchdog@archiver.kernel.org>; Mon,  2 Nov 2020 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1819922277
	for <linux-watchdog@archiver.kernel.org>; Mon,  2 Nov 2020 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604337710;
	bh=fPs4EPfKqvlmlb/tOy51lO0g49GhViopJRiBECXI3NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dGyCq1P56aX8JMYBqTy5xMNV+XsIuzEbS+lodUY8ozSaxf50i5O5EOyLkMvG0zTqM
	 jfEMvcm+nOKhbiT0GKb0nIO81OHtRo/SwfPQhJBnXTQ7pDg3qjTpbwciq6jTRO4z+7
	 hCasxjX+1IB3TiOcLu5i9YAZR5PzwdjwzO795xck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKBRVt (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:21:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45094 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRVt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 2 Nov 2020 12:21:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id k3so1439124otp.12;
        Mon, 02 Nov 2020 09:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=keAgsMAjlDKL3BqdQ4rPJ329f9ORm3baZ2gH5JuwApA=;
        b=V71cX2WY7ZPxJlrTfMURABYkVt1Wpnxd7RNI7e12xLrmGSfRvl0hjVMcvRytJhcqBC
         NTCVh8DxadDMEK41C/zK9FJZ8KMuxGtxeFjJkXCGBVWdC8x8fpczUXkYKN9C/SbpyNlB
         54ITgjecdz2JAkrmnmf1uaRpYXy2DxRU/RzYvw7QGd1WwimRKF+FFcTg5QQRglYEGsrj
         roATTR7Gn++10Ir781MWxkubmrC3pQJc2dXw1uC85p96//lgNDyBjFmii3aYWok94Oxy
         tGpTq+KGJjVEbrfpk330pGWygjwk7vgr4MnKY6HrL/yjbDB141i/Wtsid8Ps2MSfmcze
         9QhA==
X-Gm-Message-State: AOAM532iGBVrCD17HRdU8lxhqxggDFDFKvX/u698UqOiDKmH1azqVQbY
        vvnEdwlMRaAXVEQBgR6yhvzbPq43qQ==
X-Google-Smtp-Source: ABdhPJx1oybu2YdTvMMjPOEnuklKXxUVP5ULuP77lfePunzoFZPkwpI/uZbaPkaNnBjiVqEYu/5/4Q==
X-Received: by 2002:a9d:1449:: with SMTP id h67mr12078804oth.136.1604337708005;
        Mon, 02 Nov 2020 09:21:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z22sm3593258ooe.21.2020.11.02.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:21:47 -0800 (PST)
Received: (nullmailer pid 4073294 invoked by uid 1000);
        Mon, 02 Nov 2020 17:21:46 -0000
Date:   Mon, 2 Nov 2020 11:21:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     vijayakannan.ayyathurai@intel.com
Cc:     linux-watchdog@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com, mgross@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com, linux@roeck-us.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH v1 2/2] dt-bindings: watchdog: Add bindings for Intel
 Keem Bay SoC
Message-ID: <20201102172146.GA4073001@bogus>
References: <cover.1604292525.git.vijayakannan.ayyathurai@intel.com>
 <3aa5d9e2031b4646b7f0c9831f4ea9cafffb2691.1604292525.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa5d9e2031b4646b7f0c9831f4ea9cafffb2691.1604292525.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, 02 Nov 2020 13:23:12 +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> Add Device Tree binding document for Watchdog IP in the Intel Keem Bay SoC.
> 
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Acked-by: Mark Gross <mgross@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../bindings/watchdog/intel,keembay-wdt.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml:10:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1391929

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

