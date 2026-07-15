Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F64A0C;
	Wed, 15 Jul 2026 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096461; cv=none; b=jc9tmuN4PxlW1xnlaRaqXXaYDMFc6C6jC+tT2q+uyB5Ot+BOig9TwUSF4kjZZKRsNr+Tnqa0RzH5zbKI65VwzYPTfx/ZVVVJQw5fNAn9Eel4ZqcSni2e8vBZx0vvGvzMwWDsT/IJ8XxbcLq2ouVRlc5xqefeTZzCA36wm3CCpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096461; c=relaxed/simple;
	bh=spZLxdSOVyZGE9MOwEP/9vXkn4srYGz/29OX0kvrxeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYVEeNaQilF0i42gCHFxeRM8ktVT9zU6LeU4EqLlp95n9QkSwJXjlieOgpzbFK3WmzZvaJbK2G5W+Khk2d75W03U8nqAjeROh2uqtNVSHI9uIBMYhKy68gpng9Ncm+Nfm9j3V8PgEo7ryXAvcZYRjCu9HP1WWHmWSoO/UZoey6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1074F202219;
	Wed, 15 Jul 2026 08:20:55 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wjszG-001tLk-34;
	Wed, 15 Jul 2026 08:20:54 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wjszG-0000000BfZt-3VLd;
	Wed, 15 Jul 2026 08:20:54 +0200
Date: Wed, 15 Jul 2026 08:20:54 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
	kernel@pengutronix.de, avaneesh.dwivedi@oss.qualcomm.com,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] power: reset: pscrr: record reset cause on panic and
 watchdog pretimeout
Message-ID: <alcmxtlQ43J2HVsP@pengutronix.de>
References: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Faruque,

On Tue, Jul 14, 2026 at 03:22:33PM +0530, Faruque Ansari wrote:
> This series extends the Power State Change Reason Register (PSCRR)[1]
> framework to capture two additional reset causes.
> 
>   1. Kernel panic — a panic notifier writes PSCR_KERNEL_PANIC to NVMEM
>      before the system resets, so the next boot can distinguish a panic
>      from other reset causes.
> 
>   2. Watchdog pretimeout — set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) is
>      called from watchdog_notify_pretimeout(), when the watchdog fire its
>      pre-reset notification before resetting the system, so the reason gets
>      saved and we know its was a watchdog timeout that caused the reset.

Thank you, LGTM!

Right now I'm on a netdev conference, will need to take a closer look
after it.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
