Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57941 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab2C2J6m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Mar 2012 05:58:42 -0400
Received: by pbcun15 with SMTP id un15so3205009pbc.19
        for <linux-watchdog@vger.kernel.org>; Thu, 29 Mar 2012 02:58:42 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 Mar 2012 15:28:42 +0530
Message-ID: <CAHgx9Od5pNGTRN36N+bRjxDtW8pDrSGnr8GA+o0YWyqVuNX0fQ@mail.gmail.com>
Subject: Designware Timer Source Code
From: Tushar K <tushark.kernel@gmail.com>
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I am planning to use the driver which is present in the linux kernel
3.3. I am working on Linux kernel tree 3.0.23.
I am back porting this driver drivers/clocksource/dw_apb_timer.c, but
have below questions.

1) I am working on ARM SoC, can I use this code as it is? It has some
implementation related to of (Open Firmware). Other drivers in my
systems are not suing this framework. I am new to this and hence
require your inputs to move forward.
2) Is this mandatory to use Open Framework? Why other drivers under
ARM does not use this? What advantages we will have by using this?

Thanks & Regards,
Tushar
