Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784336;
	b=u1nI1E4S92h3QntfJws1aFnd3V1GWgWsoRMzwTovbQN9a8DeFt7Os6ga7enP3d0I6NFF
	 kfETaBA1bMBNCHtGr83mOqAGBwvTV+TNd62dXS5n+ovbtJs8A0uakd0KyDl1nFSPqVkTC
	 57ivFUzW4NGpeIqsc6pC/wTSM1psfLG36dHqJz0u1RdA07BJYSVbciexQNBakbxGQOJqP
	 MDNS1vwJ9vjdGHLKUC0qnAlr9vpd2/CWBCaUf9HE8YSp3nyMDvEUuY3rjXvvdzWp10faw
	 PTyT7SHmKBG3PQ6adec6igc81xJBdVxxiJCnMRqNq6itfwsfbzDjaRlV4V9H5OG3Jwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9hepJ/0RhKbpniqaAoeTQp7wePFt1SLXV7JBtX3slUM=;
	b=JAPnqvn5wYGKks8OWLZu1d8NE5YPVJVP6hZOrGzkzZtyY0AaXS/rFnJrKbpNaiCwqgVI
	 QX+L9MnSjk3WcniUNlvhtl/h2yt2n1k1sN+FWatXQuanGf4tPzUx8jNtvYzbJfI/plQpM
	 e+gyNYE+wyh7UWWBcNwziDeBsJivaK30lwRkUBiXxdp5qKvHu02UjR+6/Q8sLIPlTksoP
	 ycn1eah8eBAWxXqrgLTS1FVXLWHUKTNOnLCROdW3dT28Twz1bQxh7RUHi/E9eLYbNhmLk
	 8lM9c08IEQsmKMx37qDzs4yJboe3DJ7MWGtu4Rid1Q8jNCOYH2CyXqSoouat/yd+hqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B11EncSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5B606A321
	for <linux-watchdog@vger.kernel.org>; Fri, 23 Oct 2026 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B11EncSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0FB1F01825;
	Fri, 23 Oct 2026 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784335;
	bh=9hepJ/0RhKbpniqaAoeTQp7wePFt1SLXV7JBtX3slUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B11EncSjVBHGNeIwS1GCF73AxjurUiowBx64TrQ1gTCqCIwVOQBXEeZUx7GLAZN0E
	 vBhP85V5aWpCmmmvOhLIyBv1Sv9Q1PFUD/WCj4cTLvRuiybyo21RSyx6UDSiEhfzyx
	 ohgf/WsIHMPZonbG4oAq0A5gxQDxb+pICgMyEtpuMj5LkoktfjNhGHxbonS9p7PZ/F
	 MG3G338w3HUy22amRrTwxAp5Zb8VE5Uk7L8XIL7UR+OoqsukS+lOg7PvGzVQDcTgTG
	 3Vfwsidy3rKWcs83UGDYpiq04NC9uPE9EdanzsYFzkUmN8z6mp0kbbKpI3IPem0e/m
	 vwVdWIkBLaC+g==
Message-ID: <sashiko-outbox-183127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: octeon-wdt: Add a panic_on_timeout parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carl Smith" <carl.smith@alliedtelesis.co.nz>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261023191530.327734-1-carl.smith@alliedtelesis.co.nz>
References: <20261023191530.327734-1-carl.smith@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:38:55 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] watchdog: octeon-wdt: undocumented panic_on_timeout module parameter
--

commit 3f30c4c06ea7c605e88ff05165b08aa4592f832c
Author: Carl Smith <carl.smith@alliedtelesis.co.nz>

watchdog: octeon-wdt: Add a panic_on_timeout parameter

This commit adds a panic_on_timeout module parameter to the octeon-wdt driv=
er
so that a kernel panic can be triggered when the software heartbeat expires,
allowing crash loggers such as mtdoops to record the event before the
hardware watchdog resets the board.

> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon=
-wdt-main.c
> index 171b46d780e6f..d29a638998475 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -107,6 +107,11 @@ module_param(disable, int, 0444);
>  MODULE_PARM_DESC(disable,
>  	"Disable the watchdog entirely (default=3D0)");
> =20
> +static bool panic_on_timeout;
> +module_param(panic_on_timeout, bool, 0444);
> +MODULE_PARM_DESC(panic_on_timeout,
> +	"Panic when the heartbeat expires, instead of a silent reset (default=
=3D0)");

[Severity: Low]
Should the new panic_on_timeout parameter in drivers/watchdog/octeon-wdt-ma=
in.c
also be documented in Documentation/admin-guide/kernel-parameters.txt (and
Documentation/watchdog/watchdog-parameters.rst)?

Because panic_on_timeout is registered with module_param() with mode 0444 a=
nd
CONFIG_OCTEON_WDT defaults to built-in on CAVIUM_OCTEON_SOC, passing
octeon_wdt.panic_on_timeout on the kernel command line is the primary way to
enable it when built-in, and kernel parameters exposed via module_param() a=
re
expected to be documented in Documentation/admin-guide/kernel-parameters.tx=
t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023191530.3277=
34-1-carl.smith@alliedtelesis.co.nz?part=3D1
