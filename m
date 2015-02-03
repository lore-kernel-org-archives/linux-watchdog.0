Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47915 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965401AbbBCB6d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 20:58:33 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YISl8-0038sD-DF
	for linux-watchdog@vger.kernel.org; Tue, 03 Feb 2015 01:58:34 +0000
Message-ID: <54D02B3A.2010802@roeck-us.net>
Date: Mon, 02 Feb 2015 17:58:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	wim@iguana.be
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, paul@crapouillou.net
Subject: Re: [PATCH_V2 2/2] watchdog: jz4740: Add DT support
References: <1422528506-39954-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422528506-39954-3-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1422528506-39954-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/29/2015 02:48 AM, Zubair Lutfullah Kakakhel wrote:
> Add DT support to the jz4740 driver. Simple of_match_ptr. No other
> modification for probe needed
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Reviewed-by: Guenetr Roeck <linux@roeck-us.net>
>
s/Guenetr/Guenter/

