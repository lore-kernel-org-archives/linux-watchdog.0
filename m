Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33171 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbFHTfU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Jun 2015 15:35:20 -0400
Message-ID: <5575EE6F.3030001@roeck-us.net>
Date: Mon, 08 Jun 2015 12:35:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] watchdog_core: Add watchdog registration deferral
 mechanism
References: <1433629537-21925-1-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433629537-21925-1-git-send-email-jtheou@adeneo-embedded.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/06/2015 03:25 PM, Jean-Baptiste Theou wrote:
> Currently, watchdog subsystem require the misc subsystem to
> register a watchdog. This may not be the case in case of an
> early registration of a watchdog, which can be required when
> the watchdog cannot be disabled.
>
> This patch introduces a deferral mechanism to remove this requirement.
>
> Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> ---
> Changes in v4:
>   - Adjust patch based on Guenter feedbacks on v3
>

You still have lines with > 80 columns, primarily because of very long
variable names. I would suggest to pick shorter names - there is no
technical reason for variables named watchdog_deferred_registration_XXX,
and I don't see why we should have checkpatch warnings just because
of long variable names.

Also, multi-line alignment is still not correct.
I would suggest to run the patch through checkpatch --strict.

Thanks,
Guenter

