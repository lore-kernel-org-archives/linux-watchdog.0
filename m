Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53659 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754084Ab2DTSXN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Apr 2012 14:23:13 -0400
Received: by lahj13 with SMTP id j13so7671840lah.19
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Apr 2012 11:23:11 -0700 (PDT)
Message-ID: <4F91A94D.7070908@mvista.com>
Date: Fri, 20 Apr 2012 22:22:05 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: wim@iguana.be, grant.likely@secretlab.ca, rob.herring@calxeda.com,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v3] wdt: Device tree support for pnx4008-wdt
References: <1334933184-19418-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1334933184-19418-1-git-send-email-stigge@antcom.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

On 04/20/2012 06:46 PM, Roland Stigge wrote:

> This patch adds watchdog support to pnx4008-wdt.c

    s/watchdog/device tree/

> Signed-off-by: Roland Stigge<stigge@antcom.de>
> Reviewed-by: Arnd Bergmann<arnd@arndb.de>

WBR, Sergei
