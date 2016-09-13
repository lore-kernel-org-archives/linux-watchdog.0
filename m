Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36995 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbcIMUwj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Sep 2016 16:52:39 -0400
Subject: Re: [PATCH v2 6/6] selftests: move watchdog tests from
 Documentation/watchdog
To: Shuah Khan <shuahkh@osg.samsung.com>, corbet@lwn.net,
        richardcochran@gmail.com, wim@iguana.be, linux@roeck-us.net,
        nab@linux-iscsi.org, maheshkhanwalkar@gmail.com, arnd@arndb.de,
        ghackmann@google.com, ben@decadent.org.uk, thuth@redhat.com,
        christopher.s.hall@intel.com, john.stultz@linaro.org,
        sergei.shtylyov@cogentembedded.com, mpe@ellerman.id.au,
        jani.nikula@linux.intel.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1473795601.git.shuahkh@osg.samsung.com>
 <328de4c08ef23fe13cec88b45e3e1725cfc5c33b.1473795601.git.shuahkh@osg.samsung.com>
 <57D8628D.3070507@codeaurora.org>
 <3eb32f56-eac7-e0ca-0bcf-90488cbff458@osg.samsung.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <57D86713.7050809@codeaurora.org>
Date: Tue, 13 Sep 2016 15:52:35 -0500
MIME-Version: 1.0
In-Reply-To: <3eb32f56-eac7-e0ca-0bcf-90488cbff458@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Shuah Khan wrote:
> Is watchdog-simple a test or a sample/example? I thought this
> is an example, and planning to move that under examples?
>
> If this is a test, I will re-do the patch to include it.

I guess it's really just a sample.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
