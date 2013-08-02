Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52342 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab3HBX6p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Aug 2013 19:58:45 -0400
Message-ID: <51FC47B5.5050103@roeck-us.net>
Date: Fri, 02 Aug 2013 16:58:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jonas Jensen <jonas.jensen@gmail.com>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v8] watchdog: Add MOXA ART watchdog driver
References: <1375101228-10930-1-git-send-email-jonas.jensen@gmail.com> <1375454445-15589-1-git-send-email-jonas.jensen@gmail.com>
In-Reply-To: <1375454445-15589-1-git-send-email-jonas.jensen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/02/2013 07:40 AM, Jonas Jensen wrote:
> This patch adds a watchdog driver for the main hardware watchdog timer
> found on MOXA ART SoCs.
>
> The MOXA ART SoC provides one writable timer register, restarting
> the hardware once it reaches zero. The register is auto decremented
> every APB clock cycle.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Still wondering where the requirement comes from not to use unlikely()
in probe functions. Must be one of those tribal knowledge things people
have been talking about.

Nevertheless, still

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

