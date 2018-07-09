Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39378 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933795AbeGIRkz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jul 2018 13:40:55 -0400
Subject: Re: [PATCH v4 5/6] arm64: dt: set initial SR watchdog timeout to 60
 seconds
To: Ray Jui <ray.jui@broadcom.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-6-git-send-email-ray.jui@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <12894566-960c-6d62-539b-2e4f09cce366@gmail.com>
Date: Mon, 9 Jul 2018 10:40:49 -0700
MIME-Version: 1.0
In-Reply-To: <1527530497-10392-6-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 05/28/2018 11:01 AM, Ray Jui wrote:
> Set initial Stingray watchdog timeout to 60 seconds
> 
> By the time when the userspace watchdog daemon is ready and taking
> control over, the watchdog timeout will then be reset to what's
> configured in the daemon
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Applied to devicetree-arm64/next, thanks!
-- 
Florian
