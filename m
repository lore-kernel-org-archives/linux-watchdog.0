Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7E41CB49;
	Wed,  8 Jul 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523087; cv=none; b=n7xl3DVhlaINyUC5jkazWa8h8I/DNj9A5Gh3uhlza/9UOdfmYkg2qUaDA+JG1VBIUwOGq/gTCGY6MPHST/SfFFCfGEGTjgZrUZePP6kH87a/sXxht0aVB7nLnVYO/ja2n5eG4ANUj7XRrI5kiD8+G6LrEmLGWbm0Z2IY0lGKZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523087; c=relaxed/simple;
	bh=GSzYVgbD9D6RCoQVxPswrsU48CjASJrFjAWvcfj0kd8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YEVgfUAuzKwaIis28eAtnOHTfgcQaUOuuKaJMKK3eqxWr7GG/affiFh9tuT3bsCkK1c3a6Il5pCZDAy9JazEm0kDMWaSEDfwCrBlQRwWv+f7BWmN1p10Pk+SsfXbObXRYJlAYub3QdWYIImntoOKyrnmKRUoDfTEEZHZvRlvx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=VAjVvMZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbWEG0sD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="VAjVvMZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbWEG0sD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E3EDDEC0098;
	Wed,  8 Jul 2026 11:04:41 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 11:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783523081;
	 x=1783609481; bh=oe9CFHgxnfkNAjpoi4CT9tfcy39KRGiyUvfkXZTEM0c=; b=
	VAjVvMZPOfjpcN8AG9oOnMhkfIagw1LiwZpsvqkJMvzfWbScyarthSXKB9xpWrnC
	nRUxjWkVUiYHSq5VimbmPVG/yTtcUgsiFxXTqGOhZypObt6ZMO8CG1OElM1SMLp2
	sXewdBUTwJufwerP6uUpEdoSHCYhjcPkgeaMZwUrm9qT1MhHyWW5JLxsNF7KBIrV
	DI5L6qhdzMtARpumjd48JU0+Fbp0OoLCQS6+azeGQcJszWJgS9mAw+XxcwrwA7TL
	hZRjxNutRJ0wTkpviGfXpcXuFgIXgLRB0yL0HmP5+i1Dp9OejOXzp5IQfabUZ4iD
	4iyzFmdZWaBNnpWS7EFVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783523081; x=
	1783609481; bh=oe9CFHgxnfkNAjpoi4CT9tfcy39KRGiyUvfkXZTEM0c=; b=J
	bWEG0sDwHRdse1ddCpBlodjLTkd3aQu8IJQVw3TVsyOgHJ3SSTyowglxVexl0LW/
	fJmOoZzT5IIGAzC/9WBxzNFFtL2BZeAYwFFO1xyYxjx/SQMV7ItpuqDCd+bLTIim
	0ZN2kJmHogLve4RfdyhY9h3AJMd0oZ7T2UxmTGhvsZYvJhEL6V/X1VEu/EIkTEFj
	M0FhvEgZtExIUNcB55zWwB98mJGBp8wZRdtGs70mpx1KenJuakGLllgPUUCD/Osf
	wRPHE5Sg8pOk7z3rNMuzNULX5Ittm1r339J94kONt8lrIOFJwq8wbyMrvqtuygRw
	DJHGhGGgFbOQTT5M0TZPg==
X-ME-Sender: <xms:CWdOaibqDTCZvDxA9TmCswYuPByCsQ_6cECXs2K2-cyVzCy9cPjhQg>
    <xme:CWdOagOq4aB9DjuTnXwXWYXSvnUD-m995b_uhJ7VxbpkveLhdHKbWgj9cPamvW3Fr
    u9np7icPcv1PvDVoRuKgovFclfYfQvCW-P0vlry9gZuhAJpLRPpHQ8>
X-ME-Proxy-Cause: dmFkZTGXMMX+3CAuN0pJTc7/ojwpnknhRENJCO34bB8jhiBLZx25Y5HZSkjzwNzm6gwKBE
    iYvnN3RNeF9SQikBZm9rg/z4lhD+mo5RO9MXivxN8ayarEK/Wiq3NzIhgM2uwJFSXFvWL8
    sZziF8nB2pQHB8ctxBEzlQbssVPPGK6gWymB/Va6Tv8Ory9N5waytvLeMP7sy2Ipvv/jfx
    ux5Y7h28dXFYg/JzJmgdacEvTJBZ2XIu32KA6ztciKVf9gpAHiQeiEMn/2EeQq1Anb8S+/
    uMO7bSOxhSbTJVqM7Sn4cIS8VbWDJjexGNKjUbgeu8AE6MTa4rqvxX6DqAvPqILFK17fse
    POaKFAptUmZOY3bHxtyZHGMPQzEwvAO0i8/yjHYTfU3kFyv2CALmL5zXZ32kYb+SANCBJI
    LRyg8tXvHS4oQ7+X7m54iMKFmVTv0NV/cgrt8OqQKeiovpg0uO8sIjdEDmJWC1obwjCig7
    GRjm/GkVR9VUvhD04guljQ+XZwiSg8MSnsY9Jf8OpZHGYDZQVizJyzZY4xvViP6PikIQVo
    NUtBDDthCKMXoCOxDvoobt3v9LcQJEoqt4BzLGsyk2JQGgm+beRjmrGNLgwF8v1EcXmk9C
    LX3d5cdZyLZQfT7aP1RKXJ5wna5xjLsCC9tHgjkCNr9kFNE5VAXPVArx7O6A
X-ME-Proxy: <xmx:CWdOatA97Cl5FBSCrDRBXmDkqNLvRLFIOyDou9BKnWWdTEu_I3_d6Q>
    <xmx:CWdOam9_dcN2S-EXFzOVZ610uqWpe8A05NCves65pGHXvgSHsJVdDQ>
    <xmx:CWdOasEPxA1o6AJvC6NBceiQ_VLX2218vPJULSaWbZ-pCSQkBU9Yig>
    <xmx:CWdOasMBuwFBtdSl_RbD2yluQiKKTWAe3jiEl8zLLXgZGWkTT8nPoA>
    <xmx:CWdOagF_lfYWEV1LD7-BxyGds3oonLamh7ioVi_FJv7uvydJfuN3DU9g>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76B182CE0072; Wed,  8 Jul 2026 11:04:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArMcrDYeUHoR
Date: Wed, 08 Jul 2026 11:04:21 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9ac64046-cd69-4a2c-b2dd-4faa58ba7365@app.fastmail.com>
In-Reply-To: <6e6b5d06-be4f-4a60-a382-f636f50e4ec5@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260706145412.3833185-1-mpearson-lenovo@squebb.ca>
 <6e6b5d06-be4f-4a60-a382-f636f50e4ec5@roeck-us.net>
Subject: Re: [PATCH v3] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2
 and SE60
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2026, at 11:00 AM, Guenter Roeck wrote:
> On Mon, Jul 06, 2026 at 10:54:00AM -0400, Mark Pearson wrote:
>> Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>
> Applied.
>
Thanks Guenter. I'll work on updating the other drivers to be to the same standard.

Mark
