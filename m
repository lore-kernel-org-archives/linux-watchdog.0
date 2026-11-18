Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019842;
	b=y1ySnsLXSLhtL+P3zdo1PKVY+5NnDh7a03TtdAeqQTNBx5IRaNiBl5gv2lO3voaM02zB
	 FUgYp20OfAByge6dL9HOW6udY7SZCn/DKsL2cAx3HLk7g4xSi8bOVNz4nXWU5Ciy77kOj
	 ydymuYcrKthoDXLhfrbQORY7243drDw0lPsaXpOAtUmfHaFTN/KitjFwwYk6zfNKl+GKk
	 wlqPLE7I8DYiKza9ibTdknhHbkc6UatInZhp6fA3FlBuxugTppaRLanq6/DLFVQwlskQR
	 nOKB96yPcaNknDYO1hxz0bMLNMm2cgM/E4ASFee/OII1/lROjHza07SZdJLu380xTdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019842;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3PuxUg1W68XqcVeQwdFsUJ1UdoYaIGk5p/NFYNEmsqI=;
	b=l7r/rP7SsYH5Y739PDJljwsd+E8Hol4eXU1XE84fJottLp3CJqb8pxghUNXhMnhG8ouE
	 neUDWSyPN3pOeUuohOryPsJqkMrVWnuQVtPdpwHuAWfUm15ONAd+qC4UTOjkKMJRyFxnX
	 5iVPEJZ1Fb7JtTS+RFdQGVXvK9A6png4m0OVWOZBfIDb7febawBT2ZySuvJVzxizqDNbH
	 fYt8iSj3WOXhw95+y145L+FE9c5ccqtMkfyWfLnCe6HYF1CL21mPTa+a2Qr4fOzCg252s
	 ZjPuPjEozJllZTfWaWkpLBAwO6i08JpwPCfiuN5ZMzANlO1AdLKwfVd3Z+dI71zvr1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHi4w3mk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576F606A31C;
	Wed, 18 Nov 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHi4w3mk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D881F000C8;
	Wed, 18 Nov 2026 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019842;
	bh=3PuxUg1W68XqcVeQwdFsUJ1UdoYaIGk5p/NFYNEmsqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dHi4w3mktKxZKBR1jENFnTDvtk0OFCuIffS1Qy1+yvVPh6ZnusJAqE0i7QzQpsjbj
	 jUjdxWg7RMTI/xHAAi1NmRfjEK8Af7Fc2ckpfrw3JEDirV+XF7E1edY6H5Ng8XSC0r
	 17dmY4BLbpsi74rxY9jaSEelrlgVsqpsf6inteVkE4xOiCy34R8w0jUjNKuMdyla97
	 WGRqC7HUCoO+rcwKBYVJw89fUaOU5yVymq7sSq2NoF9xUOl+UWprlLZEmdnZtA3acZ
	 UIyiL7W6GephTCaa7GcFvlGJqI/tbMNl/ZEg3CjIm1psJ4mkSdY47kJefi52zZyTEP
	 CE4Xy4j1u555Q==
Date: Wed, 18 Nov 2026 10:37:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Subject: Re: [PATCH v4 07/15] dt-bindings: watchdog: st,stm32-iwdg: add
 access-controllers property
Message-ID: <179501983985.2891459.3666177158331281459.robh@kernel.org>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
 <20261116132416.1184447-8-antonio.borneo@foss.st.com>
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
In-Reply-To: <20261116132416.1184447-8-antonio.borneo@foss.st.com>


On Mon, 16 Nov 2026 14:24:08 +0100, Antonio Borneo wrote:
> Add the optional access-controllers property to reference one
> domain access controllers protecting the watchdog peripheral.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261106163429.618392-1-antonio.borneo%40foss.st.com?part=5
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>  Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

