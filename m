Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157266;
	b=zmMKuPyptQ32A7SNt5BMH2VKMNSmdTksFyZP7yB3St893AOzrRA1C5X7U83QuexfViQk
	 CScdZF+JvQu0b520+yD2mhRDXgck5WvGeDzIvrApgWSWh8ycZstgPXsoMQRhbz6tWBgnY
	 SHc0J7L9orXHN0sJ26PeWYNWSB6+b34c1dQqz8NwXMmqfQld9SptrBTaJmZkyTJxbdjDv
	 BGdQzmG2KQYJrOVg++61OeOF3+1zf1dhwP3kiZWq0lFtQj8EjWSYsRi27aQ38oiNMx1B0
	 NGYLEjefDzNnS/MY5CCUWlhG5qtMPVaXtqHuBVDis9y8GCuq6XBfgJfYc+HMr0xwAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157266;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JRL9OEi1et/rWUWh8shtsPs2FAzi8N33e6h2MX5LALw=;
	b=ubZB2KQ7KWx+8u7fLF3VzFgvZc87rFXS1ZOaeqhZt3H0NpHvHKHHSfKrLQu80V3FcVZE
	 gOqwmmnx1MVEJK//lNUfxW/yP3HudDWgJ3TaGz1AD7pOXIxn8gH+vkQ2eqouWp60b4aba
	 Gievc/jT4YWJVcKeWsN2nxaPxKDINlBoTq5e8GVbBLpoQDETrjq7AyC9V9MZPwAUqDSaH
	 QZWJG0AVroheMRY8WbaoIy8lcMQt+LUT66ZtFLdJXxjg1P2OuL17nxAdAv3Ghs44WI1/I
	 LzPcW/Ai6bbW2k5msTj7sb914kTXNZK48eM9fM/wMP7S5OpAG9d/YWiUT6wKo7Os2sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UyBB8f/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30E606A31A
	for <linux-watchdog@vger.kernel.org>; Wed, 28 Oct 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyBB8f/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DBC1F01828;
	Wed, 28 Oct 2026 03:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157265;
	bh=JRL9OEi1et/rWUWh8shtsPs2FAzi8N33e6h2MX5LALw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UyBB8f/iKlpjvlkhLvgpwSG1wXGDpLgmRTGb/yBFlGnqtpzB4MqpSvN/c+AS6aQsh
	 vTYmHnC526Uo1uq1mvXFTa0/hIHBjUVlQ7iqn6DyLIbHTqsU1JafAA+qSbjOgw/x6+
	 hGNnNKepbSKgHxljjM1O/QF6FiQq5EYNpde4l0nRJqPjvI5Dh3go0tXGpxWr6M4iZR
	 05bpFZPTRjnvLV+93BvzX6b2XwLchXbS5HIelaCVcwKwUKl9NXWUWd9wafzidwvfBJ
	 jhuFbrISHZ54y4o5qsZGb7B5UtRjcpv3C4nD+WW5pLvW5MjeGeTZ4c58+vEQEzG6Fm
	 NF0XxYuBpTh2Q==
Date: Wed, 28 Oct 2026 03:14:23 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 5/8] watchdog: core: Restore WDOG_HW_RUNNING if
 stopping watchdog fails
Message-ID: <auFoj8dTQc9YORh3@google.com>
References: <20261027160302.2519282-1-linux@roeck-us.net>
 <20261027160302.2519282-6-linux@roeck-us.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027160302.2519282-6-linux@roeck-us.net>

On Tue, Oct 27, 2026 at 09:02:59AM -0700, Guenter Roeck wrote:
> In watchdog_stop(), WDOG_HW_RUNNING is cleared before calling
> wdd->ops->stop(). If wdd->ops->stop() returns an error, WDOG_ACTIVE
> remains set, but WDOG_HW_RUNNING is left cleared. As a result,
> subsequent calls to watchdog_ping() become no-ops, and
> watchdog_release() sees watchdog_hw_running() as false and drops the
> module and device references while the ping worker (guided by
> WDOG_ACTIVE) continues to run.
> 
> Restore WDOG_HW_RUNNING if wdd->ops->stop() fails.
> 
> Fixes: 3c10bbde10fe ("watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function")
> Assisted-by: LLM
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
