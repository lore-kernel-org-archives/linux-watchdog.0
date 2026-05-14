Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF56318EC5;
	Thu, 14 May 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775014; cv=none; b=JvrtvF1qj+1Uu48R9NNFINkkPUmm408/h4/qH/XUtUIUUarprjiAk4PSLPT2oNZ+/fFTOEvq+kosteW/p/7CHYvmeW7Bn3C8qNojxr2aMKKS8OS1OWyZ4TSF5m3mo+CFtaQH0gkjbly27RiMrIKL48bnw2Kdft3HzoJLs4rkenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775014; c=relaxed/simple;
	bh=uKZ1Dtp/YG08FQiXlmJoAu8fRy0zw6TyjB7UZNNgOcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/YxdPpYYHnhAo9WI4815NGdjYYwQHPKZxdNHQI0pF0fVbiMAUk+cQO6wamOqOdqxqq9bV62MydtRnKfJ/ZCVMFV1PPOHiSlNIEyesV4BbXZW7PH7IKfXze/JecccO/fbciuWADet/cizKdKQs3V4TyvikR3W9Rbw5dbaxUZdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRtvAuYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRtvAuYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDD0C2BCB3;
	Thu, 14 May 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775013;
	bh=uKZ1Dtp/YG08FQiXlmJoAu8fRy0zw6TyjB7UZNNgOcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRtvAuYUQqTbbarsEnHMKPp0gBasHGDWlFMydasGspbba9ZAHXPBwy/6YIMFKrbBx
	 afAwbIabNmX8ElXiKIdJBIUZc9AGazVz9x1BXRY4JHFjO/cGuOhgukJu5v0xZhxLLt
	 75GSBa8nau04OV9ZBf4OgSMV0fHDmqYlGKTJn8Gr6D0PAxyMzojdTz5sCjnma3D4WV
	 eiVUQQRUJYbJjX26FTTwKYwE0L37b4YTA36PNRRC8iQChKYyTXHSg27vQ2GbfbC8wX
	 6GS00hXqEkNUf8F9iRkYW4kivaWiOWE05X/U1zh8nerABY11RkilpqrQGA9oKNQL83
	 Ju5ZYzmwjK6fg==
Date: Thu, 14 May 2026 11:10:08 -0500
From: Rob Herring <robh@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2]  watchdog: realtek-otto: add fallback compatible
Message-ID: <20260514161008.GB841147-robh@kernel.org>
References: <20260512204854.8931-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512204854.8931-1-sander@svanheule.net>

On Tue, May 12, 2026 at 10:48:52PM +0200, Sander Vanheule wrote:
> Like for the GPIO hardware of the Realtek Otto platform, add a fallback
> compatible for the watchdog hardware.
> 
> For backward compatibility, the binding will still allow current
> single-compatible devicetrees to work, but new devicetrees, including
> new compatibles, should use a two-component compatible.
> 
> This series serves to address comments regarding the device compatibles
> for the patches adding RTL9607C watchdog support [1].
> 
> [1] https://lore.kernel.org/lkml/20260509163101.722793-1-adilov@disroot.org/

You misunderstood the discussion (though some came after this). The 
fallback should be one of the existing compatibles (the oldest one), so 
there are no driver changes needed for the OS. Creating a new fallback 
completely misses that point.

Rob
