Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43225 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422857AbeCBI2o (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 2 Mar 2018 03:28:44 -0500
Received: by mail-lf0-f65.google.com with SMTP id q69so12193899lfi.10
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Mar 2018 00:28:43 -0800 (PST)
Subject: Re: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6b8545fa-4f74-82df-76a2-8b0bbb44c67f@cogentembedded.com>
Date: Fri, 2 Mar 2018 11:28:41 +0300
MIME-Version: 1.0
In-Reply-To: <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello!

On 3/1/2018 9:17 PM, Fabrizio Castro wrote:

> On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
> on R-Car Gen3 we power the IP down during suspend.
> 
> This commit adds suspend/resume support, so that the watchdog counting
> "pauses" during suspend on all of the SoCs compatible with this driver
> and on those we are now adding support for (R-Car Gen2 and RZ/G1).

    Why these parens here?

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
[...]

MBR, Sergei
