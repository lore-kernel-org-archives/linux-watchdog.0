Return-Path: <SRS0=sDHB=QO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA5CC169C4
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 01:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC32175B
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 01:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU1ZQw8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfBGBQs (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 6 Feb 2019 20:16:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBGBQr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Feb 2019 20:16:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3751114pga.9;
        Wed, 06 Feb 2019 17:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q7kDSL+/mt2SwVTrt6KXOyU2oVQXk/Tvnf3jcyyv05s=;
        b=aU1ZQw8a9owPMFr/C6JDV7uMYZnrC+Y13vqtf7GaY4k3lyJgKCU64uzH2B4KOrvZW1
         eo8tVoOULvzspXaxVYi/N9O+sT8HE1mpgyuh2UdYJSpgvexvVxnhV1ClvD9UTypYpr+e
         ReX/EOeBSitNdW/9byxpB8+Yd57O5IehZtwAWSKRWVBQWlOE4iJLnc5PC6CqWma8NnVZ
         Cdg64Mh27Auy0goTe+wPxVQRby2ZMHbajUlCzT5CM3u0CvG4uUkpDqWoMGMgz2TX3SQQ
         pQYVFuJrkIfEmpaQfjOJDL+SMvPDGfxYYn4u0hllZKf6bIaP4Ce2DyXgKlv/b+ljABj0
         QVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q7kDSL+/mt2SwVTrt6KXOyU2oVQXk/Tvnf3jcyyv05s=;
        b=eredJJuoLER9jbSvwwfDOaFYNwJ6qxRPrLsBDtSi4Vfsh74DIPYqmnEoi5Nk30Rjss
         AVRyNP+8LKzwfMuKY4cdxXp6CRXEYXEg89ycEM9o15Cb/KKR0Rovd7kzBp3edujEDrx0
         4uY+fAzvpIXCSUiurbQJZC7yfvYhLVPg76yn3CrREpwO7x6QfU0pm+FRhJTjz5SWjKxB
         C2h8K7DvoaTedcX58SqYG6g6mX7szT/QRZ2c73FOftOcvo2ddfebhYTz62PQhYSmi54H
         KqZJTUarS/kAuRZJ8si7I1ktHISMyCDy9t9OWKcyJYbJrJ/QRtXCZ4RXvWh+RjmMJE2C
         vPnQ==
X-Gm-Message-State: AHQUAubbtiliHmBWDK4lH1f0C+agT+M1IW3UDz9IcKFozTkkBrLOJXy6
        JADkDkyfzWB3DHOpX0uFC/0aPgMQ
X-Google-Smtp-Source: AHgI3IbqKWVMOdmnoPcqo08Tk7k+EVtEsGdQtyvNP1o/dgmYgi+SrFAx6qpluppnaPXnyph4+g/TxA==
X-Received: by 2002:a65:534b:: with SMTP id w11mr12398178pgr.125.1549502206709;
        Wed, 06 Feb 2019 17:16:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23sm3379015pfb.97.2019.02.06.17.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 17:16:45 -0800 (PST)
Subject: Re: [PATCH v1 0/3] introduce watchdog driver for Mellanox systems.
To:     michaelsh@mellanox.com, wim@linux-watchdog.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com
References: <20190206165037.4346-1-michaelsh@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ed5ec2d-02e6-956a-124d-f0bb409bf31f@roeck-us.net>
Date:   Wed, 6 Feb 2019 17:16:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190206165037.4346-1-michaelsh@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/6/19 8:50 AM, michaelsh@mellanox.com wrote:
> From: Michael Shych <michaelsh@mellanox.com>
> 
> This patchset introduces watchdog driver for a various range of Mellanox
> Ethernet and Infiniband switch systems.
> Mellanox watchdog device is implemented in programmable logic device.
> There are 2 types of HW watchdog implementations with diferent capabilities.
> This mlx-wdt driver supports both HW watchdog implementations.
> Mellanox system can have 2 watchdogs: main and auxiliary.
> Main and auxiliary watchdog devices can be enabled together on the same system.
> There are several actions that can be defined in the watchdog:
> system reset, start fans on full speed and increase register counter.
> 

I assume you submitted this twice. If there are differences, please describe
the differences in the next version.

Guenter

> Michael Shych (3):
>    platform_data/mlxreg:	addittions for mellanox watchdog driver.
>    watchdog: mlx-wdt: introduce watchdog driver for Mellanox systems.
>    Documentation/watchdog: Add documentation mlx-wdt driver
> 
>   Documentation/watchdog/mlx-wdt.txt   |  48 +++++
>   drivers/watchdog/Kconfig             |  16 ++
>   drivers/watchdog/Makefile            |   1 +
>   drivers/watchdog/mlx_wdt.c           | 406 +++++++++++++++++++++++++++++++++++
>   include/linux/platform_data/mlxreg.h |   6 +
>   5 files changed, 477 insertions(+)
>   create mode 100644 Documentation/watchdog/mlx-wdt.txt
>   create mode 100644 drivers/watchdog/mlx_wdt.c
> 

