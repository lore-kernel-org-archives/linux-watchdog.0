Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94C44236A;
	Tue,  6 Oct 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296761; cv=none; b=OGtETccLLpnpho4qjccec/kMsBFtNrSurMZlRDYZTiGlHoUtMAQjOQnn9UtT9CcZMQ/oWSNlkCbiZpVgJqVFFV4k05d6ir8fM50k0Q1Zpp9+ZVWsocZ6J6es7WxgOSsDajnyzRbbdpMNvnwghb6tYkUWZqxVDkeA7K1HDlM2XEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296761; c=relaxed/simple;
	bh=58B1ddD0bDgLOMdhxF+WEswXvMTtPNEPKRJwaSKVgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GePu84raXpp3VcuiyZyDCTJ1biTGa2Jepd15bxTlFQ/wHvb0/z2xmoT2+qOlwhMIum910UUVzKOBGiGdwahBzpcSh2wQBGPhODPUb+Btvs/OdzrQEfONtFrkEF0NpeJ7LL4oFGSc9RFksAcpVsgZyYsCAiQogpO+LSqAzLCNaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk1WWapT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk1WWapT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBAB1F000FF;
	Tue,  6 Oct 2026 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296760;
	bh=HRZTZBQQkFbRudeH2578gmIh2EUFE7i5dzEQ4ykqzm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mk1WWapTTcf8AdgsrZSd9bgCycGtQRVvk/gryFdetHLHNHNzEXkU7YP9AwzQwWNqD
	 XqvA2DQgeMuwzvy/aFxXXO0Hv0EUNcidXFaJ+hW+gMy1vorphigrWJ3OsEDSBvNXFg
	 xOX9MgmaJ6Iqzy6zAzWYD3LTitOE9E7g01OElIYauLRClM3ly/Dn9/M0PzCHrf/srC
	 8VtCdnGvegYDoK1M0HrzbYYiiwado3xNX4YeEqXTc1RGzZOgKq2yX76ZXG2A/cFC+e
	 zJf4n/8Jb1gjQ57txziC3AiEc/RdbmhPKEYNg5eGfBkf52Bz0g2RJlGwROedmPItkP
	 q2MbwPRE+eUIw==
Date: Tue, 6 Oct 2026 14:25:57 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/6] watchdog: w83627hf_wdt: Report all initialization
 failures in probe
Message-ID: <asUE9eMeey5C42L4@google.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
 <20261004-w83627hf_wdt-improvements-v3-6-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-6-8e27b518595e@bootlin.com>

On Sun, Oct 04, 2026 at 02:12:54PM +0200, Paul Louvel wrote:
> @@ -549,12 +549,12 @@ static int wdt_probe(struct platform_device *pdev)
>  		}
>  
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret, "failed to set watchdog timeout\n");
>  	}
>  
>  	ret = devm_watchdog_register_device(dev, wdd);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "failed to register watchdog\n");

Could this patch be split and squashed into the earlier patches in the
series?
