Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D515E5DC;
	Mon,  4 May 2026 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900423; cv=none; b=cpPdyjK6WHRK3AuHTq22VV627bubeyZf9F9PdXtZcJcVRIpJPE4fdx2hUsQOBs+mD76ZfT7RamLa3ezJ3dswQBKookP/Axxm+Jo8wu6bvNqhQzu9RxOUp8ZGzl6yQw962To0D0l3pAVBeKekuYMHs9CP2M4GXvr/luUzjxuKGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900423; c=relaxed/simple;
	bh=SXbk9y5kdR3JXd2SVEYP7ce94HmG9+BAivPjHozCmi8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FyrIbDVKYA0qOYyHn9iBzDUDZOT0F9jDihw2Q/UnRF1fWH4WdydVszcoQ0MlZa7md9b4/s64cVaaOk5t12f3Mwd/UJZrXoMWlwQlUMam9Ejfb97ldh4db+0ozi1V0B78vnk7Tbf6qT+l/PTH02eQRxlYlZGM3CqYAKfvpi+hGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=NtCodbOk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJ/6J4Ta; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="NtCodbOk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJ/6J4Ta"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4F817A0085;
	Mon,  4 May 2026 09:13:40 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Mon, 04 May 2026 09:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777900420;
	 x=1777986820; bh=ZdacN6/kN0H8NyB9HwsSeWm2wo5egHOVpOdGA/g6tF8=; b=
	NtCodbOkzbQi9dkPUoc12AO6wyvLrC5ZJieVLr1yJiauEEMkaec6uslnkM4/tvke
	J02IotWUntDLkb4Gic8G8tys6BWmFuCQVyGYzI4ax7/Ok+NTjQGmhLxx6DpV/7wx
	Oo1YeWMgLaEyM9kYKP5nmq17jsO1N3ffmAJ2RxKPkZf0g8ILwNnae5nZX/2w8umK
	IGEAUlqWCZhGb5xI6Fz4YssLCMeBFlY5FrjDYc38n8HCLV36dLM0nr3U5y+V6OXo
	Ava89khh3QzUlLkGn/IezAhAd85q+vJ749a9p4Z0ICpsH7zPgb5RBKIilQ1iShuR
	MMgLAVCgnZYfmy9CHtM0SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777900420; x=
	1777986820; bh=ZdacN6/kN0H8NyB9HwsSeWm2wo5egHOVpOdGA/g6tF8=; b=S
	J/6J4TaEX3WxNbKnyTmrOqggxrt3VJlIcaihK2AUEzidjfekJjGChNkHnIlpZhU5
	vVdDmc4fQwRTfQx5v+WU4eTPFo+wKrb8gUcXyyBandqPpl2nlEs6/szBGo9+dWTc
	tKGUSt/fwKOBFyn3jbs4aSktbkzfhI7vPnk94qWE91uZG/eBq1SXkZWZOYophCa9
	HgOfCDoYbtE9DNHMKsR7OpRdOhvp3rKJOWkaytH2T1Wfj1WlXWSUP5om8W65LpZd
	e56a8HT2yJ2TRjjiVMeqRCKHWTxJc2widzfMOsx3BOaXsn04n6WsSnOcwc3JZeYn
	wBnatxphKlX+hQ39FR+ZA==
X-ME-Sender: <xms:g5v4aVV0mCTUrjqA5v5N6tjJATfjn2YxBPLqJ6kATpTkdOIvDubY1w>
    <xme:g5v4aQa6WF0oxOyI1tOZq0blFGdRYWV6age1Qpdpr9hQX1kQOo4CPILyfy-4BD7Sa
    tEXlW8LZ2mlviaJFqxjhWMK-qKAXTSDsIJ1VizsvRjqBTlkfHcX6iY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdq
    lhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpeevteeludffgf
    euudefgffhueeujeffuddufeehudekiedufeetfeeikeejhfeltdenucffohhmrghinhep
    shgrshhhihhkohdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhmse
    hlihhnuhigqdifrghttghhughoghdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgv
    tghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdifrghttghhughoghesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g5v4aSdiULPxN0OA7HRmrTuOCSx_9TI7O-4qXFcY99_YDOi7SKyliw>
    <xmx:g5v4aXoi8y0e61Xhh8q9WhxbB1JcwHtuVfz3qZe-qW5x2LlYxTH4gw>
    <xmx:g5v4aXBd4h2jBBIvi82BIiFWVsZgRNKb7TUneGRK7G4IkQ_cojTniw>
    <xmx:g5v4aUZPwXf6OSw4ZRW_KdAfH4vmQHJ9lFAdHS3uMnmYUDMSj2DEkA>
    <xmx:hJv4aQPC7tpF4VYcn2DRpNWdSoaAWw5-l31qwkFAlajKqVquFmMuuxpv>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1A872CE0072; Mon,  4 May 2026 09:13:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGX5bbDMO34N
Date: Mon, 04 May 2026 09:13:19 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <51993cb1-f032-488e-92a2-2b2e65af767c@app.fastmail.com>
In-Reply-To: <d9beb8ff-0ffe-42ff-8249-e12f1a4c2e2c@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260428124954.1193450-1-mpearson-lenovo@squebb.ca>
 <d9beb8ff-0ffe-42ff-8249-e12f1a4c2e2c@roeck-us.net>
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2 platform
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Guenter,

On Sun, May 3, 2026, at 5:53 PM, Guenter Roeck wrote:
> On 4/28/26 05:49, Mark Pearson wrote:
>> The Lenovo SE10 Gen 2 platform uses a watchdog chip from the same family.
>> Watchdog functionality is the same, so update the driver with the new chip
>> ID.
>> 
>> Add the Gen 2 MTM's to enable support on the platform.
>> 
>> Tested on SE10 G2.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> ... but you might want to have a look at the AI review.
> It appears that the driver has some issues.
>
> https://sashiko.dev/#/patchset/20260428124954.1193450-1-mpearson-lenovo%40squebb.ca
>
> Patches welcome ...
>
Thanks for the review.

Ack on the AI review patch - thanks for flagging that as I was unaware of those (I'd heard about sashiko.dev - but hadn't thought to check it for results).
It looks like a valid/good thing to fix. I assume it's OK if I push that as a separate patch rather than combining it with this?

Mark
