Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37467 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbFFE0b (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jun 2015 00:26:31 -0400
Message-ID: <55727675.3000204@roeck-us.net>
Date: Fri, 05 Jun 2015 21:26:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog-kernel-api: Add registration deferral
 mechanism
References: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us> <1433555212-4729-2-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433555212-4729-2-git-send-email-jtheou@adeneo-embedded.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/05/2015 06:46 PM, Jean-Baptiste Theou wrote:
> Add registration deferral mechanism capability information
>
> Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> ---
>   Documentation/watchdog/watchdog-kernel-api.txt | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index a0438f3..11c988b 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -36,6 +36,10 @@ The watchdog_unregister_device routine deregisters a registered watchdog timer
>   device. The parameter of this routine is the pointer to the registered
>   watchdog_device structure.
>
> +The watchdog subsystem contain an registration deferral mechanism,

contains, or maybe better includes.

> +which allow you to register an watchdog as early as you wish during

allows

> +the boot process, in the situation of a built-in module.

Drop part after the , as irrelevant.

Please merge this patch into the first patch; no need to keep it separate.

Thanks,
Guenter

> +
>   The watchdog device structure looks like this:
>
>   struct watchdog_device {
>

