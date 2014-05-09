Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:36544 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaEIIbt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 9 May 2014 04:31:49 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so204233lab.12
        for <linux-watchdog@vger.kernel.org>; Fri, 09 May 2014 01:31:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 9 May 2014 16:31:47 +0800
Message-ID: <CADRPPNSPwiveWEH++ZqDXH5u=mQxAiuh+Ci=1hBH1g6qz4-2dw@mail.gmail.com>
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
From: Leo Li <pku.leo@gmail.com>
To: Yuantian.Tang@freescale.com
Cc: wim@iguana.be, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 8, 2014 at 10:04 AM,  <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
>
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
>
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>

Reviewed-by: Li Yang <leoli@freescale.com>
