Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f65.google.com ([209.85.215.65]:36473 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbbG1W2n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 18:28:43 -0400
Received: by lafd3 with SMTP id d3so5865212laf.3
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 15:28:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1437973493-26872-2-git-send-email-ariel@vanguardiasur.com.ar>
References: <1437973493-26872-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1437973493-26872-2-git-send-email-ariel@vanguardiasur.com.ar>
Date: Wed, 29 Jul 2015 00:28:42 +0200
Message-ID: <CAGhQ9VzDZhrYTkpvAWntryvg=2K-f+H=yT+Wjifssz3-7pz_bQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
From: Joachim Eastwood <manabian@gmail.com>
To: "Ariel D'Alessandro" <ariel@vanguardiasur.com.ar>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 27 July 2015 at 07:04, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
> This commit adds support for the watchdog timer found in NXP LPC SoCs
> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
> share the same watchdog hardware.
>
> Watchdog driver registers a restart handler that will restart the system
> by performing an incorrect feed after ensuring the watchdog is enabled in
> reset mode.
>
> As watchdog cannot be disabled in hardware, driver's stop routine will
> regularly send a keepalive ping using a timer.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

For the LPC18xx hardware specific parts:
Reviewed-by: Joachim Eastwood <manabian@gmail.com>

regards,
Joachim Eastwood
