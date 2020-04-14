Return-Path: <SRS0=A8d8=56=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58940C2BB1D
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Apr 2020 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307AC20768
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Apr 2020 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586900627;
	bh=qZPk2As+hfAlY6M9MR4jZAZC2vEwk9TkrJMLBU+a3GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZGmSh5xSZHpbMfPlZE2sG6HYw+aCCeYNW+i6WRAOlKWiQkekRc88ypJNZu5MIKwSr
	 q7Q+ciDIlab8W7qkfM49JULjSBXITZcCwMCSQqmpCM+EExLhP2hW3WBAThEabs3xXU
	 JN9z7CyYN2Fl5SuWDyFSkceQLVPz7kzI53g+TeWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634067AbgDNVnj (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:43:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42919 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634063AbgDNVnf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Apr 2020 17:43:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id l21so1293192otd.9;
        Tue, 14 Apr 2020 14:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uvozqtfEr9bESGHX3UpchnJ8A2PhYWDydvpfuPdbYhc=;
        b=LFvHQf8Mk/gqumaNa/DXw9NVbBhHqkurBN4w0C1wN3WZK14YO6wkHWu5EKDErI5fZS
         YNMXBR8hxKofRgqXuyj5SEkdUIIqCvj3LatYo9RydZ88U+bxKBdhxfw+j/886sFYHfsZ
         6wx5dZuv2sVzh2Ld6VV4TBHw0QF6TM3BhTOS9yeM+kIkqephzqxnMXmfNhoC7EG/pHyr
         SULuh4JaLOUJ8qAPCdcUp46mfuUMWBZdKhpazOBLQYWJQeudkwLCnOk14Q83WwmaBdwW
         UoyEoG3rAE+2eMSebAFIK5z6ncv9LGodjPjvsmb8JrNRBe3MXkubmz2mUNlZebg8UH2i
         YG9g==
X-Gm-Message-State: AGi0PuYpxBY0vOPvNeGqqKdgXN5WpuKZWBUehgAjz+M+3dwuwv0yu2m/
        xVxw2Mtzx03yW/AhcZMMYQ==
X-Google-Smtp-Source: APiQypKkc3mkxopBmD8q3Q9BAh/YpU4AikDfqfbekmDrulLTaWnF6YhmPFGgCuE0Wn2xDDc3dm4eEw==
X-Received: by 2002:a9d:24a4:: with SMTP id z33mr20460527ota.105.1586900614278;
        Tue, 14 Apr 2020 14:43:34 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e3sm4970371oii.6.2020.04.14.14.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:43:33 -0700 (PDT)
Received: (nullmailer pid 9000 invoked by uid 1000);
        Tue, 14 Apr 2020 21:43:32 -0000
Date:   Tue, 14 Apr 2020 16:43:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: Convert i.MX7ULP to
 json-schema
Message-ID: <20200414214332.GA8620@bogus>
References: <1586831568-24635-1-git-send-email-Anson.Huang@nxp.com>
 <1586831568-24635-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586831568-24635-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, 14 Apr 2020 10:32:48 +0800, Anson Huang wrote:
> Convert the i.MX7ULP watchdog binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/watchdog/fsl-imx7ulp-wdt.txt          | 22 --------
>  .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         | 60 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.example.dt.yaml: watchdog@403d0000: 'timeout-sec' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1270024

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
