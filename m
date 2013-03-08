Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50637 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab3CHHMB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Mar 2013 02:12:01 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so1668006ieb.31
        for <linux-watchdog@vger.kernel.org>; Thu, 07 Mar 2013 23:12:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <513894E3.1070206@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
	<513894E3.1070206@slimlogic.co.uk>
Date: Fri, 8 Mar 2013 08:12:00 +0100
Message-ID: <CACRpkdYHhh=ANiHvgxXiAQ_4LLiBBe0AfJ-60Wy6aEi7Cv0HOg@mail.gmail.com>
Subject: Re: [PATCH v8 0/12] Palmas Updates
From: Linus Walleij <linus.walleij@linaro.org>
To: Ian Lartey <ian@slimlogic.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org, swarren@wwwdotorg.org,
	grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com,
	rob.herring@calxeda.com, rob@landley.net, mturquette@linaro.org,
	cooloney@gmail.com, rpurdie@rpsys.net, sameo@linux.intel.com,
	wim@iguana.be, lgirdwood@gmail.com, gg@slimlogic.co.uk,
	j-keerthy@ti.com, ldewangan@nvidia.com, t-kristo@ti.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 7, 2013 at 2:23 PM, Ian Lartey <ian@slimlogic.co.uk> wrote:

> This patchset adds to the support for the Palmas iseries of PMIC chips.
>
> Some of the patches have previously been submitted individually.
> The DT bindings doc has been added first due to comments that it was
> missing.

Can the patches to the individual subsystems be applied individually
(like can we apply the two GPIO patches to the GPIO tree) or are
the deps such that the whole shebang needs to go in at once and you're
just harvesting ACKs to take it all into MFD or similar?

Yours,
Linus Walleij
