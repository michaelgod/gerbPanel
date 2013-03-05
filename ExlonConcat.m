%     Gerber 274X Panelization script
%     Copyright (C) 2013 TAO-YI LEE <tylee@ieee.org>
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

% THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
% IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
% IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.
function ExlonConcat(name, N)
    if(~exist('merge','dir'))
        mkdir('merge');
    end
    file_merge = ['merge/' name '.drl'];
    try
        delete(file_merge);
    catch e
        disp('Nothing to delete......');
    end
    copyfile([name '_head.drl'],file_merge)
    fid_m = fopen(file_merge, 'a+');
    fprintf(fid_m, '%%\n');    
    fprintf(fid_m, 'G90\n');    
    fclose(fid_m); 
    
    for i=1:N-1
        file_o = [name '_M' num2str(i) '.drl'];
        fid_m = fopen(file_merge, 'a+');     
        fprintf(fid_m, 'T%02d\n', i); 
        fclose(fid_m);         
        FileCat(file_merge, file_o, 'M00') ;
    end
    fid_m = fopen(file_merge, 'a+');
    fprintf(fid_m, 'T%02d\n', N); 
    FileCat(file_merge, [name '_M' num2str(N) '.drl']) ;     
    fprintf(fid_m, 'M30\n');    
    fclose(fid_m);    
end