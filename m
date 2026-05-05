Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E247A0D1;
	Tue,  5 May 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988077; cv=none; b=GH/HopqO1YDwHbLf/PA+SF9q8kXKd0ho7wqUDESft8eyydSyacaSA4bUhAuH9uFCnI0NT5NbWfPfZCpUAXOQmVeuhFjgBlUhCJ0Kmqbv0QALOHQh8LgqvOEaONaDUnLjxfgp4Hne7jTG12ORhVb4nU6OqvItmI7jX/O/OgJ0CkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988077; c=relaxed/simple;
	bh=t9YY0zQ+ACdMLYvh60CqPGs2Xk7RIZUGbvlcjaBqXRY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=clE9sn+p0uXjiMqwEMTeSOqLQCzoq6N+pYDUcI/1YCfIHHGWeBWN87Gnc0sT3aZkowh243hrZ16f2xQDKT+jNzkmRYhbcxAAtAR3ylIlMBIevTVXg7bxAeurKPj4Q7ssbxIo4aCcL60QGfzKuEOhIOzT+rJdqKf6b1Lm9GYPkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=vlOKkXz5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFsZuEpi; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="vlOKkXz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFsZuEpi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74A0F7A00AF;
	Tue,  5 May 2026 09:34:34 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 05 May 2026 09:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777988074;
	 x=1778074474; bh=yAxack9sybjtERmw5VDjn80rJvjdSDsRDLHylTkmfzY=; b=
	vlOKkXz5A7dBqOq7LtKa/ylb+v4gj30WAGuHDHdPbpo2cVFcVL8nFNDqT8xSCIuw
	pCXhP+iv+4ryq+xS6DS6KySA5Ybu8to5ek+Rfccea/wVydRbqKku8grPX423udyh
	STc+aw4MCU1je3JZ+DG/vgPu0yDaYj/8786DM0cXm6Ia6JOilpCHXJdaGIXqe3Rb
	rD7HNrA3IKwiCDFbsu/4dleuu3jqLFl8IOsnEOf5K+ivcB1vjMUFwEN95A4/ghjy
	Vk+GimH38R/5bW/socU39BKBsYR7xpM8wptVqa2sb4E8LatItv7j5nfkxWB8ehuO
	ec1O6lWTFODHgAd8CZL9hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777988074; x=
	1778074474; bh=yAxack9sybjtERmw5VDjn80rJvjdSDsRDLHylTkmfzY=; b=T
	FsZuEpi78ZG2o4gmmUUiosQOWG258tySwoseiXJ3/jTKK5rz6s0r7MsDTkAWA+IV
	gNOeGBGK7WTimNJ440qoTTtRnZBWts7WKI9YOV3ZZEBB8pELMME07Mt2/13Fm8W7
	pGhiFIQ/UOBaS4OgMLuG7JGyhASBvjEQhGmrJ2U1afj/8hRQCfQL3nT+iaWp2Ha2
	kA5oBSDUXIy9B6jwJAmzRTJ7exkYsFCiv++w8eKpaSEFJ0TBI8x1umRhDo0CjF4h
	lw3P+/e/amdWf/2KMWb6djUKbfiUktD97Mi91zq7PRzzNr7lWI4jCImecdfzZQWi
	vOpR2pM3oQYMaYSheR1cg==
X-ME-Sender: <xms:6vH5acqgf4psnlFKW17mheNBiiN6I4d80FvboKVRHNILkZNEwoCQyQ>
    <xme:6vH5adfFk-RZ_RteZ5Diwo5g1EyLcB9pdCGLS7g2tUh092iQ5bsa0CByiZmuDrYnx
    OtmJNhLwOhZe8qLf4swP1RyechEjmUMmFdvoHYWLY8_6JGx38NpPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddukeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhn
    qdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepveetleduff
    fguedufefghfeuueejffduudefhedukeeiudefteefieekjefhledtnecuffhomhgrihhn
    pehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihimh
    eslhhinhhugidqfigrthgthhguohhgrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhho
    vggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhgsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6vH5adSU6JGMymazG0VgguyPcXamIRJuvfxs-NerGw8NrDzyzRtXtg>
    <xmx:6vH5aSMkxG9G1lC5zj_slNQp5XkxnHxq3W5K7vPPiEjKoHYyTWAqfQ>
    <xmx:6vH5aWXoKQEE7q9Oq2vqDpK06DsbqeY7RJTn2E9_pACcDKO2cjauMQ>
    <xmx:6vH5aZeX6xOuc5ps1P19q127Xz_VWVs2tHFtG_T_ayKgcCx0fEluDw>
    <xmx:6vH5aZxrgJBXSNk5_k6MaoCZgdRn1cG7fACmfnBG5z8XqNlmDW_1FwXd>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E70C72CE0072; Tue,  5 May 2026 09:34:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVu7clCfesfZ
Date: Tue, 05 May 2026 09:34:13 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1b92e904-bb9a-4ca4-909f-b2adbd4d4d04@app.fastmail.com>
In-Reply-To: <975e78c6-1898-472e-ba39-1721e2555940@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260504180159.999189-1-mpearson-lenovo@squebb.ca>
 <975e78c6-1898-472e-ba39-1721e2555940@roeck-us.net>
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Fix use-after-free and resource leak
 risk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 5, 2026, at 9:15 AM, Guenter Roeck wrote:
> On Mon, May 04, 2026 at 02:01:42PM -0400, Mark Pearson wrote:
>> Review by sashiko.dev highlighted potential use after free and resource
>> leak instances.
>> 
>> Set se10_pdev to null to prevent use after free
>> 
>> Remove DMI call back and instead directly call
>> se10_create_platform_device. Handle error cases appropriately
>> 
>> Link: https://sashiko.dev/#/patchset/20260428124954.1193450-1-mpearson-lenovo%40squebb.ca
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Applied to my watchdog-next branch.
>
> Thanks,
> Guenter

Thanks for the review
Mark
