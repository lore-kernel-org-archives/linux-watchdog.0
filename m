Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64740 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab2CZKXP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Mar 2012 06:23:15 -0400
Received: by pbcun15 with SMTP id un15so5825043pbc.19
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Mar 2012 03:23:14 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 26 Mar 2012 15:53:14 +0530
Message-ID: <CAHgx9OeuaSB9Xm6ruPE_m4HOn=E3zHzvxX_Y-NgzURjqs=9JWQ@mail.gmail.com>
Subject: DesignWare Watchdog Code
From: Tushar K <tushark.kernel@gmail.com>
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I am going through the DW Watchdog code in linux kernel 3.3 (dw_wdt.c)
file. I could not see any interrupt handling in this file. Am I
missing something?
Please tell me how interrupt is getting handled in this case? Also how
to add this device into the Linux kernel? (I tried to check few BSPs
but could not find which is using this IP.) I wanted to look at the
other SoC BSP to see how that's been used for reference.

Thanks & Regards,
Tushar
